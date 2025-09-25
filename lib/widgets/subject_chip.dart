import 'package:book_hunt/screens/subject_books/subject_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/subject_provider.dart';

class SubjectChip extends StatelessWidget {
  final String subject;
  const SubjectChip({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(subject),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SubjectBooksScreen(subject: subject),
          ),
        );

        // background me data fetch
        context.read<SubjectProvider>().fetchBooksBySubject(subject);
      },
    );
  }
}
