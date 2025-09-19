import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/author_provider.dart';

class AuthorScreen extends StatefulWidget {
  final String authorId;

  const AuthorScreen({super.key, required this.authorId});

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  @override
  void initState() {
    super.initState();

    // ✅ Fetch author detail on screen open
    Future.microtask(() {
      context.read<AuthorProvider>().fetchAuthor(widget.authorId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthorProvider>();
    final author = provider.getAuthor(widget.authorId);

    return Scaffold(
      appBar: AppBar(title: const Text("Author Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : author == null
            ? const Center(child: Text("Author not found"))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 📌 Name
                  Text(
                    author.name ?? "Unknown",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 📌 Birth date
                  if (author.birthDate != null)
                    Text("Born: ${author.birthDate}"),

                  const SizedBox(height: 12),

                  // 📌 Bio
                  Text(
                    author.bio?.value ?? "No biography available",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
      ),
    );
  }
}
