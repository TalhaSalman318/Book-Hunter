import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/providers/book_provider.dart';
import 'package:book_hunt/providers/cover_provider.dart';
import 'package:book_hunt/screens/search/searched_item_screen.dart';
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

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<BookProvider>(
        context,
        listen: false,
      ).fetchTrendingBooks(),
    );
    Future.microtask(
      () => Provider.of<CoverProvider>(context, listen: false).getCoverUrl(
        /* Provide a valid coverId here, e.g. 0 or a default value */
        0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchBookProvider = Provider.of<SearchBooksProvider>(context);
    final bookProvider = Provider.of<BookProvider>(context);

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Hunt')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔍 Search Bar
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
                      final query = searchController.text;
                      searchBookProvider.search(
                        query,
                      ); // ye provider update karega
                      searchBookProvider.search(searchController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SearchedItemScreen()),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubjectChip(subject: "action"),
                  SubjectChip(subject: "history"),
                  SubjectChip(subject: "biography"),
                  SubjectChip(subject: "places"),
                  SubjectChip(subject: "fiction"),
                  SubjectChip(subject: "animals"),
                ],
              ),
            ),
            // 📌 Trending Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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

            // 🔥 Trending Books List
            SizedBox(
              height: 250.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bookProvider.trendingBooks.length,
                itemBuilder: (context, index) {
                  final book = bookProvider.trendingBooks[index];
                  final bookModel = BookWorkModel.fromJson(book);

                  return BookCard(
                    // title: bookModel.title ?? 'No title',
                    key: ValueKey(bookModel.key),
                    bookWorkModel: bookModel,
                  );
                },
              ),
            ),

            // 📌 Recently Added Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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

            // 📚 Recently Added Books List
            SizedBox(
              height: 250.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bookProvider.trendingBooks.length,
                itemBuilder: (context, index) {
                  final book = bookProvider.trendingBooks[index];
                  final bookModel = BookWorkModel.fromJson(book);

                  return BookCard(
                    // title: bookModel.title ?? 'No title',
                    key: ValueKey(bookModel.key),
                    bookWorkModel: bookModel,
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
