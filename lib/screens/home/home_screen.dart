import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/providers/book_provider.dart';
import 'package:book_hunt/providers/cover_provider.dart';
import 'package:book_hunt/screens/work_detail/work_details_screen.dart';
import 'package:book_hunt/widgets/book_card.dart';
import 'package:book_hunt/widgets/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/search_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<BookProvider>(
        context,
        listen: false,
      ).fetchTrendingBooks(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final serachBookProvider = Provider.of<SearchBooksProvider>(context);
    final coverProvider = Provider.of<CoverProvider>(context);
    final bookProvider = Provider.of<BookProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Hunt')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
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
                    serachBookProvider.search(searchController.text);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Most Popular",
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: bookProvider.trendingBooks.length,
              itemBuilder: (context, index) {
                final book = bookProvider.trendingBooks[index];
                // // JSON ko model me convert karo
                final bookModel = BookWorkModel.fromJson(book);
                return BookCard(
                  title: book['title'] ?? 'No title',
                  key: ValueKey(bookModel.key),
                  bookWorkModel: bookModel,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
