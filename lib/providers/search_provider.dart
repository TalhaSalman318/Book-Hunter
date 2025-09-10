import 'package:flutter/material.dart';
import 'package:book_hunt/repositories/book_repository.dart';

class SearchBooksProvider extends ChangeNotifier {
  final BookRepository repository;
  SearchBooksProvider(this.repository);

  bool isLoading = false;
  List<dynamic> results = [];

  Future<void> search(String query) async {
    if (query.isEmpty) return;

    isLoading = true;
    notifyListeners();

    results = await repository.searchBooks(query);

    isLoading = false;
    notifyListeners();
  }
}
