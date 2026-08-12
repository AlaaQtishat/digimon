import 'package:dio/dio.dart';

class ApiService {
  late final Dio _dio;

  ApiService({required String baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
      ),
    );
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200) {
        print("--- [ApiService] Success! Data fetched from: $endpoint ---");
        return response.data;
      } else {
        print(
          "--- [ApiService] Server Error. Status Code: ${response.statusCode} ---",
        );

        throw Exception('Server error occurred. Please try again later.');
      }
    } on DioException catch (e) {
      print("--- [ApiService] Dio Error: ${e.message} ---");

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception(
          'Connection timed out. Please check your internet connection.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection available.');
      }

      throw Exception(
        'Network error. Please check your connection and try again.',
      );
    }
  }
}
