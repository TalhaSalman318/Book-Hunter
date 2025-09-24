import 'package:book_hunt/providers/editions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/models/edition.dart';

class EditionsScreen extends StatefulWidget {
  final String workId;

  const EditionsScreen({super.key, required this.workId});

  @override
  State<EditionsScreen> createState() => _EditionsScreenState();
}

class _EditionsScreenState extends State<EditionsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<EditionProvider>().fetchEditions(widget.workId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final editionProvider = context.watch<EditionProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Book Editions")),
      body: editionProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : editionProvider.errorMessage != null
          ? Center(
              child: Text(
                "Error: ${editionProvider.errorMessage}",
                style: const TextStyle(color: Colors.red),
              ),
            )
          : editionProvider.editions.isEmpty
          ? const Center(child: Text("No editions found"))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: editionProvider.editions.length,
              itemBuilder: (context, index) {
                final edition = editionProvider.editions[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(
                      edition.title ?? "No Title",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Publish Date: ${edition.publishDate ?? "Unknown"}",
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // yahan baad mein edition detail screen khol sakte ho
                    },
                  ),
                );
              },
            ),
    );
  }
}
