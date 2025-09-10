import 'package:book_hunt/services/open_library_api.dart';

class BookRepository {
  final OpenLibraryApi api;
  BookRepository(this.api);

  Future<List<dynamic>> searchBooks(String query) async {
    final data = await api.searchBooks(query);
    return data['docs'] ?? [];
  }

  Future<Map<String, dynamic>> getWorkDetail(String workId) async {
    return await api.getWorkDetail(workId);
  }

  Future<Map<String, dynamic>> getAuthor(String authorId) async {
    return await api.getAuthor(authorId);
  }

  Future<List<dynamic>> getEditions(String workId) async {
    final data = await api.getEditions(workId);
    return data['entries'] ?? [];
  }
}
