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
      onPressed: () async {
        try {
          // ✅ pehle data fetch karo
          await context.read<SubjectProvider>().fetchBooksBySubject(subject);

          // ✅ fir ensure karo ke context mounted hai
          if (!context.mounted) return;

          // ✅ ab safe push kar sakte ho
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SubjectBooksScreen(subject: subject),
            ),
          );
        } catch (e) {
          debugPrint("Error in SubjectChip: $e");
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Failed to load subject: $e")));
        }
      },
    );
  }
}
