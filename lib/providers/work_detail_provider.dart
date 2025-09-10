import 'package:flutter/material.dart';
import 'package:book_hunt/repositories/book_repository.dart';

class WorkDetailProvider extends ChangeNotifier {
  final BookRepository repository;
  WorkDetailProvider(this.repository);

  bool isLoading = false;
  Map<String, dynamic>? workDetail;
  String? errorMessage;

  Future<void> fetchWorkDetail(String workId) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      workDetail = await repository.getWorkDetail(workId);
    } catch (e) {
      errorMessage = "Failed to load work details: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
