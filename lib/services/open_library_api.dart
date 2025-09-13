import 'network_client.dart';

class OpenLibraryApi {
  final NetworkClient client;
  OpenLibraryApi(this.client);

  /// Search books by query (title/author/ISBN depending on params)
  Future<Map<String, dynamic>> searchBooks(
    String query, {
    int page = 1,
    int limit = 20,
  }) {
    return client.get(
      "/search.json",
      queryParams: {
        "q": query,
        "page": page,
        "limit": limit,
        "fields": "key,title,author_name,first_publish_year,cover_i",
      },
    );
  }

  /// Work details
  Future<Map<String, dynamic>> getWorkDetail(String workId) {
    return client.get("/works/$workId.json");
  }

  /// Editions of a work
  Future<Map<String, dynamic>> getEditions(
    String workId, {
    int limit = 20,
    int offset = 0,
  }) {
    return client.get(
      "/works/$workId/editions.json",
      queryParams: {"limit": limit, "offset": offset},
    );
  }

  /// Author details
  Future<Map<String, dynamic>> getAuthor(String authorId) {
    return client.get("/authors/$authorId.json");
  }

  /// Works by an author
  Future<Map<String, dynamic>> getAuthorWorks(
    String authorId, {
    int limit = 20,
    int offset = 0,
  }) {
    return client.get(
      "/authors/$authorId/works.json",
      queryParams: {"limit": limit, "offset": offset},
    );
  }

  /// Search authors
  Future<Map<String, dynamic>> searchAuthors(
    String query, {
    int limit = 20,
    int offset = 0,
  }) {
    return client.get(
      "/search/authors.json",
      queryParams: {"q": query, "limit": limit, "offset": offset},
    );
  }

  /// Subject books
  Future<Map<String, dynamic>> getSubject(
    String subject, {
    int limit = 25,
    int offset = 0,
    bool details = true,
  }) {
    return client.get(
      "/subjects/$subject.json",
      queryParams: {
        "limit": limit,
        "offset": offset,
        "details": details.toString(),
      },
    );
  }

  /// 🔹 Utility functions for cover & author photo (no network call needed)
  String coverUrlFromCoverId(int coverId, {String size = "M"}) {
    return "https://covers.openlibrary.org/b/id/$coverId-$size.jpg";
  }

  String authorPhotoUrl(String authorId, {String size = "M"}) {
    return "https://covers.openlibrary.org/a/olid/$authorId-$size.jpg";
  }
}
