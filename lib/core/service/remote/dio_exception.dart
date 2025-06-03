 // Centralized custom error handling
import 'package:dio/dio.dart';

class DioExceptions {
  static String fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout";
      case DioExceptionType.sendTimeout:
        return "Send timeout";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout";
      case DioExceptionType.badResponse:
        return "Received invalid status code: ${e.response?.statusCode}";
      case DioExceptionType.cancel:
        return "Request to API server was cancelled";
      case DioExceptionType.connectionError:
        return "Connection failed";
      default:
        return "Unexpected error occurred";
    }
  }
}
