import 'package:book_hunt/models/author.dart';
import 'package:flutter/foundation.dart';
import 'package:book_hunt/repositories/author_repository.dart';

class AuthorProvider with ChangeNotifier {
  final AuthorRepository repository;
  AuthorModel? _author;
  AuthorProvider(this.repository);

  AuthorModel? get author => _author;
  bool isLoading = false;
  String? errorMessage;
  Map<String, dynamic>? authorDetail;

  /// Fetch author details
  Future<void> fetchAuthor(String authorId) async {
    _setLoading(true);
    try {
      authorDetail = await repository.getAuthor(authorId);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
