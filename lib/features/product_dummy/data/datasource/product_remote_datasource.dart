import 'package:dio/dio.dart';
import 'package:msc_suite_flutter_app/core/service/remote/api_executor.dart';

import 'package:msc_suite_flutter_app/features/product_dummy/data/model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiExecutor dioService;

  ProductRemoteDataSourceImpl(this.dioService);

  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await dioService.request(
        method: 'GET',
        endpoint: '/todos', // Assuming baseUrl is already set
      );

      final List data = response.data;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
