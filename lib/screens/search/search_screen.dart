import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/providers/book_provider.dart';
import 'package:book_hunt/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearch(BookProvider provider, String query) {
    if (query.trim().isNotEmpty) {
      provider.searchBooks(query.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Search Books",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            if (_controller.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  // bookProvider.clearSearch();
                  setState(() {});
                },
              ),
          ],
        ),
        body: Column(
          children: [
            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: "Search by title, author, or subject...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (query) => _onSearch(bookProvider, query),
              ),
            ),

            // 📚 Results / Suggestions
            Expanded(
              child: Builder(
                builder: (_) {
                  if (bookProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // 🟡 Show suggestions when no search yet
                  if (bookProvider.searchResults.isEmpty &&
                      _controller.text.isEmpty) {
                    return ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        const Text(
                          "🔥 Trending Books",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // trending books grid
                        if (bookProvider.trendingBooks.isNotEmpty)
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: bookProvider.trendingBooks.length,
                              itemBuilder: (context, index) {
                                final bookJson =
                                    bookProvider.trendingBooks[index];
                                final bookModel = BookWorkModel.fromJson(
                                  bookJson,
                                );

                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: BookCard(
                                    key: ValueKey(bookModel.key),
                                    bookWorkModel: bookModel,
                                  ),
                                );
                              },
                            ),
                          )
                        else
                          const Center(
                            child: Text("No trending books available"),
                          ),

                        const SizedBox(height: 24),
                        const Text(
                          "📚 Popular Subjects",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Wrap(
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
                                    _controller.text = subject;
                                    _onSearch(bookProvider, subject);
                                    setState(() {});
                                  },
                                );
                              }).toList(),
                        ),
                      ],
                    );
                  }

                  // ❌ No results
                  if (bookProvider.searchResults.isEmpty &&
                      _controller.text.isNotEmpty) {
                    return const Center(
                      child: Text(
                        "No results found 👀",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  // ✅ Show search results
                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.6,
                        ),
                    itemCount: bookProvider.searchResults.length,
                    itemBuilder: (context, index) {
                      final bookJson = bookProvider.searchResults[index];
                      final bookModel = BookWorkModel.fromJson(bookJson);

                      return BookCard(
                        key: ValueKey(bookModel.key),
                        bookWorkModel: bookModel,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
