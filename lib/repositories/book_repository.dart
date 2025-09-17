import 'package:book_hunt/models/recent_add_model.dart';
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

  // Recent Add
  Future<List<RecentAddModel>> getRecentBook() async {
    final data = await api
        .recentAddBooks(); // ye Map<String, dynamic> return karega
    final changes = data['changes'] as List? ?? [];

    return changes
        .map((json) => RecentAddModel.fromJson(json as Map<String, dynamic>))
        .toList();
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
