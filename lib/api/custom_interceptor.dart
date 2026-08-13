import 'package:dio/dio.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String userMessage = 'Something went wrong. Please try again.';

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      userMessage =
          'Connection timed out. Please check your internet connection.';
    } else if (err.type == DioExceptionType.connectionError) {
      userMessage = 'No internet connection available.';
    } else if (err.type == DioExceptionType.badResponse) {
      final statusCode = err.response?.statusCode;
      if (statusCode == 404 || statusCode == 400) {
        userMessage = 'Data not found in database.';
      } else if (statusCode != null && statusCode >= 500) {
        userMessage = 'Server error. Please try again later.';
      } else {
        userMessage = 'Unable to process your request.';
      }
    }

    final customError = DioException(
      requestOptions: err.requestOptions,
      error: userMessage,
      type: err.type,
      response: err.response,
    );

    super.onError(customError, handler);
  }
}
