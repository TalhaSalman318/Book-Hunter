import 'package:book_hunt/services/open_library_api.dart';

class SubjectRepository {
  final OpenLibraryApi api;
  SubjectRepository(this.api);

  /// Get books by subject
  Future<List<Map<String, dynamic>>> getBooksBySubject(
    String subject, {
    int limit = 20,
    int offset = 0,
  }) async {
    final data = await api.getSubject(subject, limit: limit, offset: offset);
    return List<Map<String, dynamic>>.from(data['works'] ?? []);
  }
}
