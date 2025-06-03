import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:msc_suite_flutter_app/core/utils/helper_utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioService {
  static final DioService _instance = DioService._internal();

  factory DioService() => _instance;

  late Dio _dio;

  DioService._internal() {
    _dio = Dio(
        BaseOptions(
          // https://jsonplaceholder.typicode.com/todos
          baseUrl:
              'https://jsonplaceholder.typicode.com', // Replace with actual base URL
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

  Dio get dio => _dio;

  Future<Response<dynamic>> makeApiRequest({
    dynamic body,
    required String method,
    required String endpoint,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,

    int retryCount = 3,
    bool sendHeader = true,
    Duration retryDelay = const Duration(seconds: 2),
    bool showInternetConnectionMessage = false,
  }) async {
    final dio = _configureDio();

    final isConnected = await Helper.isNetworkAvailable();

    if (!isConnected) {
      // Optional: handle offline data store
      if (showInternetConnectionMessage) {
        throw DioException(
          requestOptions: RequestOptions(path: endpoint),
          error: "No internet connection.",
          type: DioExceptionType.connectionError,
        );
      }
    }

    return _performRequestWithRetry(
      dio: dio,
      body: body,
      method: method,
      endpoint: endpoint,
      sendHeader: sendHeader,
      cancelToken: cancelToken,
      retryCount: retryCount,
      retryDelay: retryDelay,
      queryParameters: queryParameters,
    );
  }

  Dio _configureDio() {
    final dio = DioService().dio;
    dio.options
      ..connectTimeout = Duration(seconds: 20)
      ..receiveTimeout = Duration(seconds: 20);
    return dio;
  }

  Future<Response<dynamic>> _performRequestWithRetry({
    required Dio dio,
    required dynamic body,
    required String method,
    required String endpoint,
    required bool sendHeader,
    required int retryCount,
    required Duration retryDelay,
    required CancelToken? cancelToken,
    required Map<String, dynamic>? queryParameters,
  }) async {
    int attempt = 0;

    while (attempt < retryCount) {
      try {
        // log("➡️ API CALL [$method] $endpoint");
        final response = await dio.request(
          endpoint,
          queryParameters: queryParameters,
          data: body,
          cancelToken: cancelToken,
          options: Options(
            method: method,
            headers: sendHeader ? await _defaultHeaders() : null,
          ),
        );
        // log("✅ RESPONSE [${response.statusCode}]: ${response.data}");
        return response;
      } on DioException catch (e) {
        await _handleDioError(e, attempt, retryCount, retryDelay);
        attempt++;
      }
    }

    throw DioException(
      requestOptions: RequestOptions(path: endpoint),
      error: 'API call failed after $retryCount attempts.',
    );
  }

  Future<Map<String, dynamic>> _defaultHeaders() async {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // Add token or auth headers if needed
    };
  }

  Future<void> _handleDioError(
    DioException e,
    int attempt,
    int retryCount,
    Duration retryDelay,
  ) async {
    log("❌ ERROR [${e.type}] - ${e.message}");

    if (attempt < retryCount - 1) {
      log("🔁 Retrying in ${retryDelay.inSeconds}s... ($attempt/$retryCount)");
      await Future.delayed(retryDelay);
    } else {
      log("⚠️ Error: ${e.message}");
    }
  }
}
