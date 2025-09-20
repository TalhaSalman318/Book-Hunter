import 'package:flutter/material.dart';
import 'package:book_hunt/repositories/book_repository.dart';
import 'package:book_hunt/models/edition.dart';

class EditionProvider extends ChangeNotifier {
  final BookRepository repository;
  EditionProvider(this.repository);

  bool isLoading = false;
  String? errorMessage;
  List<Entries> editions = []; // sirf entries ka list

  Future<void> fetchEditions(String workId) async {
    if (workId.isEmpty) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await repository.getEditions(workId);
      editions = response.map((e) => Entries.fromJson(e)).toList();
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
