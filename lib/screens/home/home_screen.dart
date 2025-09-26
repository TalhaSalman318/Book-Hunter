import 'package:book_hunt/core/env.dart';
import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/providers/book_provider.dart';
import 'package:book_hunt/providers/cover_provider.dart';
import 'package:book_hunt/screens/search/searched_item_screen.dart';
import 'package:book_hunt/services/recent_search_service.dart';
import 'package:book_hunt/widgets/book_card.dart';
import 'package:book_hunt/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/search_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  final recentSearchService = RecentSearchService();
  final FocusNode _focusNode = FocusNode();

  List<String> recentSearches = [];
  bool showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();

    _focusNode.addListener(() {
      setState(() {
        showSuggestions = _focusNode.hasFocus;
      });
    });

    Future.microtask(
      () => Provider.of<BookProvider>(
        context,
        listen: false,
      ).fetchTrendingBooks(),
    );

    Future.microtask(
      () => Provider.of<CoverProvider>(context, listen: false).getCoverUrl(0),
    );
  }

  Future<void> _loadRecentSearches() async {
    final searches = await recentSearchService.getSearches();
    setState(() {
      recentSearches = searches;
    });
  }

  Future<void> _onSearch(String query) async {
    if (query.isEmpty) return;

    await recentSearchService.addSearch(query);
    await _loadRecentSearches();

    await Provider.of<SearchBooksProvider>(
      context,
      listen: false,
    ).search(query);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SearchedItemScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,

        automaticallyImplyLeading: false,
        title: const Text(
          'Book Hunt',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(height: 1.h, color: AppColors.navBarGray),
          ),

          // 🔍 Search Bar + Suggestions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search books...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () => _onSearch(searchController.text.trim()),
                    ),
                  ),
                  onSubmitted: (value) => _onSearch(value.trim()),
                ),

                if (showSuggestions && recentSearches.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recentSearches.map((query) {
                        return ListTile(
                          dense: true,
                          leading: const Icon(Icons.history, size: 20),
                          title: Text(query),
                          onTap: () {
                            searchController.text = query;
                            FocusScope.of(context).unfocus();
                            _onSearch(query);
                          },
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),

          // 📌 Baaki content scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 📌 Subjects
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            [
                              "Science",
                              "History",
                              "Technology",
                              "Fiction",
                              "Business",
                              "Art",
                            ].map((subject) {
                              return ActionChip(
                                label: Text(subject),
                                onPressed: () {
                                  searchController.text = subject;
                                  _onSearch(subject);
                                  setState(() {});
                                },
                              );
                            }).toList(),
                      ),
                    ),
                  ),

                  // 📌 Trending Section
                  _buildSectionHeader("Most Popular", width),
                  _buildBookList(bookProvider),

                  // 📌 Recently Added Section
                  _buildSectionHeader("Recently Added", width),
                  _buildBookList(bookProvider),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                "More",
                style: TextStyle(
                  color: AppColors.fontGreyColor,
                  fontSize: 20.sp,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: width * 0.04,
                color: AppColors.fontGreyColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookList(BookProvider bookProvider) {
    return SizedBox(
      height: 250.h,
      child: bookProvider.isLoading || bookProvider.trendingBooks.isEmpty
          ? ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => const BookCardShimmer(),
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
            )
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: bookProvider.trendingBooks.length,
              itemBuilder: (context, index) {
                final bookJson = bookProvider.trendingBooks[index];
                final bookModel = BookWorkModel.fromJson(bookJson);

                return BookCard(
                  key: ValueKey(bookModel.key),
                  bookWorkModel: bookModel,
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
            ),
    );
  }
}
