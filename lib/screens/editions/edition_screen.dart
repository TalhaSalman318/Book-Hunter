import 'package:book_hunt/core/env.dart';
import 'package:book_hunt/models/book_work.dart';
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
  final searchController = TextEditingController();
  List editions = [];
  List filteredEditions = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final provider = context.read<EditionProvider>();
      await provider.fetchEditions(widget.workId);
      setState(() {
        editions = provider.editions;
        filteredEditions = editions;
      });
    });
  }

  void _filterEditions(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredEditions = editions;
      });
    } else {
      setState(() {
        filteredEditions = editions
            .where(
              (edition) => (edition.title ?? "").toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final editionProvider = context.watch<EditionProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Editions")),
      body: Column(
        children: [
          Expanded(
            child: editionProvider.isLoading
                ? const SearchShimmer()
                : editionProvider.errorMessage != null
                ? Center(
                    child: Text(
                      "Error: ${editionProvider.errorMessage}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : filteredEditions.isEmpty
                ? const Center(child: Text("No editions found"))
                : GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: editionProvider.editions.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 0,
                          childAspectRatio: 0.65,
                        ),
                    itemBuilder: (context, index) {
                      final edition = editionProvider.editions[index];

                      // edition se workId nikaalo
                      final workId = (edition.works?.isNotEmpty ?? false)
                          ? edition.works!.first.key?.replaceAll("/works/", "")
                          : null;

                      if (workId == null) return const SizedBox.shrink();

                      final bookModel = BookWorkModel(
                        key: workId,
                        title: edition.title ?? "No Title",
                        covers:
                            (edition.covers != null &&
                                edition.covers!.isNotEmpty)
                            ? edition.covers
                            : [], // yahan list pass karo
                      );
                      return BookCard(
                        key: ValueKey(bookModel.key),
                        bookWorkModel: bookModel,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
