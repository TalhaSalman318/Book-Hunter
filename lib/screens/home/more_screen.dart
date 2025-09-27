import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreBooksScreen extends StatelessWidget {
  final String sectionTitle;
  final List books;

  const MoreBooksScreen({
    super.key,
    required this.sectionTitle,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sectionTitle)),
      body: books.isEmpty
          ? const Center(child: Text("No books available"))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final bookJson = books[index];
                final bookModel = BookWorkModel.fromJson(bookJson);
                return BookCard(
                  key: ValueKey(bookModel.key),
                  bookWorkModel: bookModel,
                );
              },
            ),
    );
  }
}
