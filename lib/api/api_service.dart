import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'custom_interceptor.dart';

class ApiService {
  late final Dio _dio;

  ApiService({required String baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
      ),
    );

    _dio.interceptors.add(
      PrettyDioLogger(
        //this is for logging the request and response in a pretty format
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    _dio.interceptors.add(
      CustomInterceptor(),
    ); //this is for handling errors and customizing error messages
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.error.toString());
    } catch (e) {
      throw Exception('Unexpected error occurred.');
    }
  }
}
