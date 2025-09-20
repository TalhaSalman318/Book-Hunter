import 'package:book_hunt/providers/editions_provider.dart';
import 'package:book_hunt/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          ? Center(child: Text(editionProvider.errorMessage!))
          : ListView.builder(
              itemCount: editionProvider.editions.length,
              itemBuilder: (context, index) {
                final edition = editionProvider.editions[index];

                final title = edition.title ?? "Untitled";
                final coverUrl =
                    (edition.covers != null && edition.covers!.isNotEmpty)
                    ? "https://covers.openlibrary.org/b/id/${edition.covers![0]}-M.jpg"
                    : "";

                return BookCard(
                  bookWorkModel: null!,
                  // title: title,
                  // coverUrl: coverUrl
                );
                ;
              },
            ),
    );
  }
}
