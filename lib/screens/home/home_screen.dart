import 'package:book_hunt/screens/work_detail/work_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_hunt/providers/search_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchBooksProvider>(context);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Book Hunt")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search box
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Search books...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    provider.search(controller.text);
                  },
                  child: const Text("Search"),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Results
            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: provider.results.length,
                      itemBuilder: (context, index) {
                        final book = provider.results[index];
                        final title = book['title'] ?? "Untitled";
                        final author =
                            (book['author_name'] != null &&
                                book['author_name'].isNotEmpty)
                            ? book['author_name'][0]
                            : "Unknown";
                        final workId = (book['key'] as String).replaceFirst(
                          "/works/",
                          "",
                        );

                        return ListTile(
                          title: Text(title),
                          subtitle: Text(author),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    WorkDetailScreen(workId: workId),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
