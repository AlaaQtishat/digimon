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
        return response.data;
      } else {
        throw Exception(
          'Failed to load data. Status Code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error occurred while fetching data: $e');
    }
  }
}
