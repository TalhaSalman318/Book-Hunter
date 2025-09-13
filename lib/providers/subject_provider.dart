import 'package:flutter/foundation.dart';
import 'package:book_hunt/repositories/subject_repository.dart';

class SubjectProvider with ChangeNotifier {
  final SubjectRepository repository;
  SubjectProvider(this.repository);

  bool isLoading = false;
  String? errorMessage;
  List<Map<String, dynamic>> subjectBooks = [];

  /// Fetch books by subject
  Future<void> fetchBooksBySubject(String subject) async {
    _setLoading(true);
    try {
      subjectBooks = await repository.getBooksBySubject(subject);
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
