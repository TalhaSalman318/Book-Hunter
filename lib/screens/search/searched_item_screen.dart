import 'package:book_hunt/core/env.dart';
import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/providers/search_provider.dart';
import 'package:book_hunt/screens/work_detail/work_details_screen.dart';
import 'package:book_hunt/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedItemScreen extends StatefulWidget {
  const SearchedItemScreen({super.key});

  @override
  State<SearchedItemScreen> createState() => _SearchedItemScreenState();
}

class _SearchedItemScreenState extends State<SearchedItemScreen> {
  final searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<String> recentSearches = [];
  bool showSuggestions = false;

  Future<void> _onSearch(String query) async {
    if (query.isEmpty) return;

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
    final searchBookProvider = Provider.of<SearchBooksProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Search Results")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    filled: true,
                    // fillColor: AppColors.searchGrey,
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
                      // color: Colors.white,
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
          Expanded(
            child: searchBookProvider.isLoading
                ? const SearchShimmer() // 👈 shimmer call
                : GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: searchBookProvider.results.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 0,
                          childAspectRatio: 0.65,
                        ),
                    itemBuilder: (context, index) {
                      final book = searchBookProvider.results[index];
                      final bookModel = BookWorkModel.fromJson(book);
                      return BookCard(bookWorkModel: bookModel);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
