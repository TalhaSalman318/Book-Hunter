import 'package:dio/dio.dart';

class NetworkClient {
  final Dio _dio;

  NetworkClient({String baseUrl = "https://openlibrary.org"})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            "Accept": "application/json",
            "User-Agent": "BookFinder/1.0 (your_email@example.com)",
          },
        ),
      );

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return response.data as Map<String, dynamic>;
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception(
          "Request failed: ${response.statusCode} ${response.statusMessage}",
        );
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 429 ||
          (e.response?.statusCode ?? 500) >= 500) {
        // Exponential backoff retry ka placeholder (implement later agar chaho)
        throw Exception("Server busy. Please try again later.");
      }
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
