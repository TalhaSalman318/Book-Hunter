import 'package:book_hunt/services/open_library_api.dart';

class BookRepository {
  final OpenLibraryApi api;
  BookRepository(this.api);

  /// Search books (works list)
  Future<List<Map<String, dynamic>>> searchBooks(
    String query, {
    int page = 1,
    int limit = 20,
  }) async {
    final data = await api.searchBooks(query, page: page, limit: limit);
    return List<Map<String, dynamic>>.from(data['docs'] ?? []);
  }

  /// Work detail
  Future<Map<String, dynamic>> getWorkDetail(String workId) async {
    return await api.getWorkDetail(workId);
  }

  // Trending
  Future<List<Map<String, dynamic>>> getTrendingBooks() async {
    final data = await api
        .trendingBooks(); // ye function aap OpenLibraryApi me banaoge
    final works = data['works'] ?? [];
    return List<Map<String, dynamic>>.from(works);
  }

  /// Editions of a work
  Future<List<Map<String, dynamic>>> getEditions(
    String workId, {
    int limit = 20,
    int offset = 0,
  }) async {
    final data = await api.getEditions(workId, limit: limit, offset: offset);
    return List<Map<String, dynamic>>.from(data['entries'] ?? []);
  }
}
