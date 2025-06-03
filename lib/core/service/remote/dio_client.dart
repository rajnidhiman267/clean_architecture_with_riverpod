// Handles Dio setup & interceptors
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://jsonplaceholder.typicode.com',
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
        ),
      )
      ..interceptors.add(
        PrettyDioLogger(
          request: true,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
  }
}
