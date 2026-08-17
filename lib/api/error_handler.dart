import 'package:dio/dio.dart';
import 'app_exceptions.dart';

class ErrorHandler {
  static AppException handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          return NetworkException();

        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 404 || statusCode == 400) {
            return NotFoundException();
          } else if (statusCode != null && statusCode >= 500) {
            return ServerException();
          }
          break;
        default:
          return UnknownException();
      }
    }
    return UnknownException();
  }
}
