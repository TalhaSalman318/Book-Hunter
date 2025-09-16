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
            "User-Agent": "BookFinder/1.0 (contact@example.com)",
          },
        ),
      );

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return "Connection timed out. Please try again.";
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return "Server took too long to respond.";
    } else if (e.type == DioExceptionType.badResponse) {
      return "Server error: ${e.response?.statusCode}";
    } else {
      return "Unexpected error occurred.";
    }
  }
}
