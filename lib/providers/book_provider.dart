import 'package:flutter/foundation.dart';
import 'package:book_hunt/repositories/book_repository.dart';

class BookProvider with ChangeNotifier {
  final BookRepository repository;
  BookProvider(this.repository);

  bool isLoading = false;
  String? errorMessage;

  List<Map<String, dynamic>> searchResults = [];
  Map<String, dynamic>? workDetail;
  List<Map<String, dynamic>> editions = [];

  /// Search books
  Future<void> searchBooks(String query) async {
    _setLoading(true);
    try {
      searchResults = await repository.searchBooks(query);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    _setLoading(false);
  }

  /// Fetch work detail
  Future<void> fetchWorkDetail(String workId) async {
    _setLoading(true);
    try {
      workDetail = await repository.getWorkDetail(workId);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    _setLoading(false);
  }

  /// Fetch editions
  Future<void> fetchEditions(String workId) async {
    _setLoading(true);
    try {
      editions = await repository.getEditions(workId);
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
