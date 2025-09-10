import 'network_client.dart';

class OpenLibraryApi {
  final NetworkClient client;
  OpenLibraryApi(this.client);

  Future<Map<String, dynamic>> searchBooks(String query) {
    return client.get("/search.json", queryParams: {"q": query});
  }

  Future<Map<String, dynamic>> getWorkDetail(String workId) {
    return client.get("/works/$workId.json");
  }

  Future<Map<String, dynamic>> getAuthor(String authorId) {
    return client.get("/authors/$authorId.json");
  }

  Future<Map<String, dynamic>> getEditions(String workId) {
    return client.get("/works/$workId/editions.json");
  }
}
