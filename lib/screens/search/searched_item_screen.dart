import 'package:book_hunt/models/book_work.dart';
import 'package:book_hunt/providers/search_provider.dart';
import 'package:book_hunt/screens/work_detail/work_details_screen.dart';
import 'package:book_hunt/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedItemScreen extends StatelessWidget {
  const SearchedItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBookProvider = Provider.of<SearchBooksProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Search Results")),
      body: searchBookProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // har row mein 2 items
                crossAxisSpacing: 12, // ✅ column ke darmiyan gap
                mainAxisSpacing: 16, // ✅ row ke darmiyan gap
                childAspectRatio: 0.65, // ✅ image aur text ka proportion
              ),
              itemBuilder: (context, index) {
                final book = searchBookProvider.results[index];
                final bookModel = BookWorkModel.fromJson(book);

                return BookCard(
                  title: book['title'],
                  bookWorkModel: bookModel,
                  coverUrl: 'coverUrl',
                );
              },
            ),
      // ListView.builder(
      //     itemCount: searchBookProvider.results.length,
      //     itemBuilder: (context, index) {
      //       final book = searchBookProvider.results[index];
      //       return ListTile(title: Text(book['title'] ?? 'No title'));
      //     },
      //   ),
    );
  }
}
