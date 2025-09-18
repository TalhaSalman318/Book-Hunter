import 'package:book_hunt/models/author.dart';
import 'package:book_hunt/providers/author_provider.dart';
import 'package:flutter/material.dart';
import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/screens/author/author_screen.dart';
import 'package:provider/provider.dart';

// AuthorChip.dart
class AuthorChip extends StatelessWidget {
  final String authorKey;

  const AuthorChip({super.key, required this.authorKey});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AuthorScreen(authorId: authorKey)),
        );
      },
      child: FutureBuilder(
        future: Provider.of<AuthorProvider>(
          context,
          listen: false,
        ).fetchAuthor(authorKey),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Chip(label: Text("Loading..."));
          }

          final author = Provider.of<AuthorProvider>(
            context,
            listen: true,
          ).author;
          return Chip(
            label: Text(author?.name ?? "Unknown"),
            avatar: const Icon(Icons.person, size: 18),
            backgroundColor: Colors.blue.shade50,
          );
        },
      ),
    );
  }
}
