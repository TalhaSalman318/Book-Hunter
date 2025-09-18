import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/author_provider.dart';

class AuthorChip extends StatelessWidget {
  final String authorId;
  final VoidCallback? onTap;

  const AuthorChip({super.key, required this.authorId, this.onTap});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthorProvider>();
    final author = provider.getAuthor(authorId);

    // Agar author already provider mein cache hai to wo dikhado
    if (author != null) {
      return _buildChip(author.name ?? "Unknown", onTap);
    }

    // Agar author nahi mila to fetch karo
    return FutureBuilder(
      future: context.read<AuthorProvider>().fetchAuthor(authorId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Chip(label: Text("Loading..."));
        }
        if (snapshot.hasError) {
          return const Chip(label: Text("Error"));
        }

        final fetched = provider.getAuthor(authorId);
        return _buildChip(fetched?.name ?? "Unknown", onTap);
      },
    );
  }

  Widget _buildChip(String name, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Chip(
        label: Text(
          name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue.shade100,
        avatar: const Icon(Icons.person, size: 18, color: Colors.blue),
      ),
    );
  }
}
