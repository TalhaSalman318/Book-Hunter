import 'package:book_hunt/services/open_library_api.dart';

class AuthorRepository {
  final OpenLibraryApi api;
  AuthorRepository(this.api);

  /// Author details by ID
  Future<Map<String, dynamic>> getAuthor(String authorId) async {
    return await api.getAuthor(authorId);
  }
}
