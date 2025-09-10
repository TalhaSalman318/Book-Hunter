import 'package:dio/dio.dart';

class NetworkClient {
  final Dio _dio;

  NetworkClient({String baseUrl = "https://openlibrary.org"})
    : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await _dio.get(endpoint, queryParameters: queryParams);
    return response.data;
  }
}
