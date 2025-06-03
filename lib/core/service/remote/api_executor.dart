//
// Handles retry logic, error handling
//
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:msc_suite_flutter_app/core/service/remote/api_helper.dart';
import 'package:msc_suite_flutter_app/core/service/remote/dio_exception.dart';
import 'package:msc_suite_flutter_app/core/utils/helper_utils.dart';
import 'dio_client.dart';

class ApiExecutor {
  final _dio = DioClient().dio;

  Future<Response> request({
    dynamic body,
    required String method,
    required String endpoint,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParams,
    int retryCount = 3,
    Duration retryDelay = const Duration(seconds: 2),
    bool sendHeader = true,
  }) async {
    final isConnected = await Helper.isNetworkAvailable();

    if (!isConnected) {
      throw DioException(
        requestOptions: RequestOptions(path: endpoint),
        error: 'No internet connection',
        type: DioExceptionType.connectionError,
      );
    }

    int attempts = 0;

    while (attempts < retryCount) {
      try {
        final response = await _dio.request(
          endpoint,
          data: body,
          queryParameters: queryParams,
          cancelToken: cancelToken,
          options: Options(
            method: method,
            headers: sendHeader ? await ApiHelper.getHeaders() : null,
          ),
        );

        return response;
      } on DioException catch (e) {
        attempts++;
        log("Attempt $attempts: ${DioExceptions.fromDioError(e)}");

        if (attempts >= retryCount) rethrow;

        await Future.delayed(retryDelay);
        // throw DioException(
        //   requestOptions: RequestOptions(path: endpoint),
        //   error: e.toString(),
        //   type: DioExceptionType.connectionError,
        // );
      }
    }

    throw Exception("Request failed after $retryCount attempts");
  }
}
