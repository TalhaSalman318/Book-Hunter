import 'package:flutter/foundation.dart';
import 'package:book_hunt/models/author.dart';
import 'package:book_hunt/repositories/author_repository.dart';

class AuthorProvider with ChangeNotifier {
  final AuthorRepository repository;
  final Map<String, AuthorModel> _authors = {}; // multiple authors
  bool isLoading = false;
  String? errorMessage;

  AuthorProvider(this.repository);

  AuthorModel? getAuthor(String id) => _authors[id];

  Future<void> fetchAuthor(String authorId) async {
    if (_authors.containsKey(authorId)) return; // already fetched

    try {
      isLoading = true;
      notifyListeners();

      final response = await repository.getAuthor(authorId);
      final author = AuthorModel.fromJson(response);

      _authors[authorId] = author;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
