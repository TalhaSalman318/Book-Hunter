import 'package:book_hunt/models/author.dart';
import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/providers/author_provider.dart';
import 'package:book_hunt/providers/book_provider.dart';
import 'package:book_hunt/widgets/author_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/work_detail_provider.dart';

class WorkDetailScreen extends StatefulWidget {
  final String workId;
  final BookWorkModel? workData; // agar data pass karna ho
  const WorkDetailScreen({super.key, required this.workId, this.workData});

  @override
  State<WorkDetailScreen> createState() => _WorkDetailScreenState();
}

class _WorkDetailScreenState extends State<WorkDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch only once when screen opens
    Future.microtask(() {
      Provider.of<WorkDetailProvider>(
        context,
        listen: false,
      ).fetchWorkDetail(widget.workId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final workDetailProvider = Provider.of<WorkDetailProvider>(context);
    final authorProvider = Provider.of<AuthorProvider>(context);
    final bookWorkModel = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Work Detail")),
      body: workDetailProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : workDetailProvider.errorMessage != null
          ? Center(child: Text(workDetailProvider.errorMessage!))
          : workDetailProvider.workDetail == null
          ? const Center(child: Text("No details found"))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workDetailProvider.workDetail!['title'] ?? "No title",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    workDetailProvider.workDetail!['description'] is Map
                        ? workDetailProvider
                                  .workDetail!['description']['value'] ??
                              "No description"
                        : workDetailProvider.workDetail!['description'] ??
                              "No description",
                  ),
                ],
              ),
            ),
    );
  }
}
