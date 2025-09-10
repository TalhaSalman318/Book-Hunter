import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/work_detail_provider.dart';

class WorkDetailScreen extends StatelessWidget {
  final String workId;
  const WorkDetailScreen({super.key, required this.workId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkDetailProvider>(context);

    // Fetch once when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchWorkDetail(workId);
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Work Detail")),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
          ? Center(child: Text(provider.errorMessage!))
          : provider.workDetail == null
          ? const Center(child: Text("No details found"))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.workDetail!['title'] ?? "No title",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    provider.workDetail!['description'] is Map
                        ? provider.workDetail!['description']['value'] ??
                              "No description"
                        : provider.workDetail!['description'] ??
                              "No description",
                  ),
                ],
              ),
            ),
    );
  }
}
