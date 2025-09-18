import 'package:book_hunt/screens/author/author_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/author_provider.dart';

class AuthorChip extends StatefulWidget {
  final String authorId;

  const AuthorChip({super.key, required this.authorId});

  @override
  State<AuthorChip> createState() => _AuthorChipState();
}

class _AuthorChipState extends State<AuthorChip> {
  @override
  void initState() {
    super.initState();

    // ✅ Author preload here
    Future.microtask(() {
      context.read<AuthorProvider>().fetchAuthor(widget.authorId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthorProvider>();
    final author = provider.getAuthor(widget.authorId);

    return ActionChip(
      label: Text(
        author?.name ?? "Unknown",
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      avatar: const Icon(Icons.person, size: 18, color: Colors.blue),
      backgroundColor: Colors.blue.shade100,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AuthorScreen(authorId: widget.authorId),
          ),
        );
      },
    );
  }
}
