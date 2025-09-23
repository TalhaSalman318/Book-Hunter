import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/providers/book_provider.dart';
import 'package:book_hunt/providers/cover_provider.dart';
import 'package:book_hunt/screens/search/searched_item_screen.dart';
import 'package:book_hunt/services/recent_search_service.dart';
import 'package:book_hunt/widgets/book_card.dart';
import 'package:book_hunt/widgets/color.dart';
import 'package:book_hunt/widgets/subject_chip.dart';
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

    // ✅ Await the search
    await Provider.of<SearchBooksProvider>(
      context,
      listen: false,
    ).search(query);

    // ✅ Pass query to screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SearchedItemScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Hunt')),
      body: Column(
        children: [
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
                    fillColor: AppColors.searchGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search books...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        _onSearch(searchController.text.trim());
                      },
                    ),
                  ),
                  onSubmitted: (value) => _onSearch(value.trim()),
                ),

                // 📌 Recent Searches Dropdown
                if (showSuggestions && recentSearches.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                            _onSearch(query); // sirf yehi chalega
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
                      child: Row(
                        children: const [
                          SubjectChip(subject: "action"),
                          SubjectChip(subject: "history"),
                          SubjectChip(subject: "biography"),
                          SubjectChip(subject: "places"),
                          SubjectChip(subject: "fiction"),
                          SubjectChip(subject: "animals"),
                        ],
                      ),
                    ),
                  ),

                  // 📌 Trending Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trending",
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "More",
                              style: TextStyle(
                                color: AppColors.fontGreyColor,
                                fontSize: width * 0.035,
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
                  ),

                  SizedBox(
                    height: 250.h,
                    child: ListView.builder(
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
                    ),
                  ),

                  // 📌 Recently Added Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recently Added",
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "More",
                              style: TextStyle(
                                color: AppColors.fontGreyColor,
                                fontSize: width * 0.035,
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
                  ),

                  SizedBox(height: 20.h),

                  SizedBox(
                    height: 250.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bookProvider.trendingBooks.length,
                      itemBuilder: (context, index) {
                        final book = bookProvider.trendingBooks[index];
                        final bookModel = BookWorkModel.fromJson(book);

                        return BookCard(
                          key: ValueKey(bookModel.key),
                          bookWorkModel: bookModel,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
