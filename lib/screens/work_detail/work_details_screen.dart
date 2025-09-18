import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/work_detail_provider.dart';
import 'package:book_hunt/providers/author_provider.dart';
import 'package:book_hunt/widgets/author_chip.dart';

class WorkDetailScreen extends StatefulWidget {
  final String workId;
  const WorkDetailScreen({super.key, required this.workId});

  @override
  State<WorkDetailScreen> createState() => _WorkDetailScreenState();
}

class _WorkDetailScreenState extends State<WorkDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WorkDetailProvider>().fetchWorkDetail(widget.workId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final workDetailProvider = context.watch<WorkDetailProvider>();

    if (workDetailProvider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (workDetailProvider.errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(workDetailProvider.errorMessage!)),
      );
    }

    final work = workDetailProvider.workDetail;
    if (work == null) {
      return const Scaffold(body: Center(child: Text("No details found")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Work Detail")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              work['title'] ?? "No title",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              work['description'] is Map
                  ? (work['description']['value'] ?? "No description")
                  : (work['description'] ?? "No description"),
            ),

            const SizedBox(height: 16),

            // Author chips
            Wrap(
              spacing: 8,
              children: (work['authors'] as List? ?? []).map((a) {
                final rawKey = a['author']?['key'] ?? "";
                final authorId = rawKey.replaceAll("/authors/", "");

                return AuthorChip(
                  authorId: authorId,
                  onTap: () {
                    // Navigate to Author Detail screen if needed
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// ✅ Separate widget for fetching and showing author chip
// class AuthorFetcherChip extends StatelessWidget {
//   final String authorId;
//   const AuthorFetcherChip({super.key, required this.authorId});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<AuthorProvider>();
//     final author = provider.getAuthor(authorId);

//     if (author != null) {
//       return AuthorChip(
//         name: author.name ?? "Unknown",
//         onTap: () {
//           // TODO: Navigate to author detail screen
//         },
//       );
//     }

//     return FutureBuilder(
//       future: context.read<AuthorProvider>().fetchAuthor(authorId),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Chip(label: Text("Loading..."));
//         }
//         if (snapshot.hasError) {
//           return const Chip(label: Text("Error"));
//         }

//         final fetched = provider.getAuthor(authorId);
//         return AuthorChip(name: fetched?.name ?? "Unknown", onTap: () {});
//       },
//     );
//   }
// }
