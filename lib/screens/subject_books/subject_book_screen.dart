import 'package:book_hunt/core/env.dart';
import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:book_hunt/providers/subject_provider.dart';
import 'package:book_hunt/widgets/book_card.dart';

class SubjectBooksScreen extends StatefulWidget {
  final String subject;

  const SubjectBooksScreen({Key? key, required this.subject}) : super(key: key);

  @override
  State<SubjectBooksScreen> createState() => _SubjectBooksScreenState();
}

class _SubjectBooksScreenState extends State<SubjectBooksScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch books for this subject when screen opens
    Future.microtask(() {
      context.read<SubjectProvider>().fetchBooksBySubject(widget.subject);
    });
  }

  @override
  Widget build(BuildContext context) {
    final subjectProvider = context.watch<SubjectProvider>();
    final bookProvider = Provider.of<BookProvider>(context);

    final books = subjectProvider.subjectBooks; // List<BookWork> assumed

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subject.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: subjectProvider.isLoading
            ? const Center(child: SearchShimmer())
            : books.isEmpty
            ? const Center(child: Text("No books found for this subject"))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.6, // Adjust as per BookCard size
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  final bookModel = BookWorkModel.fromJson(book);

                  return BookCard(
                    // <-- RETURN keyword add kiya
                    // title: bookModel.title ?? 'No title',
                    key: ValueKey(bookModel.key),
                    bookWorkModel: bookModel,
                  );
                },
              ),
      ),
    );
  }
}
