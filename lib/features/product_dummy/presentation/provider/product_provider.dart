import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msc_suite_flutter_app/core/service/remote/api_executor.dart';
import 'package:msc_suite_flutter_app/features/product_dummy/data/datasource/product_remote_datasource.dart';
import 'package:msc_suite_flutter_app/features/product_dummy/data/repositories/product_repo_impl.dart';
import 'package:msc_suite_flutter_app/features/product_dummy/domain/repositories/product_repo.dart';
import 'package:msc_suite_flutter_app/features/product_dummy/domain/usecases/get_product.dart';
import 'package:msc_suite_flutter_app/features/product_dummy/domain/entities/product.dart';

// Dio service
final dioServiceProvider = Provider<ApiExecutor>((Ref ref) => ApiExecutor());

// Remote data source
final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((
  ref,
) {
  final dio = ref.watch(dioServiceProvider);
  return ProductRemoteDataSourceImpl(dio);
});

///////
final stringvalueProvider = Provider<String>((ref) => 'hello');
///////

// Repository
final productRepositoryProvider = Provider<ProductRepositary>((ref) {
  final remoteDataSource = ref.watch(productRemoteDataSourceProvider);
  return ProductRepositoryImpl(remoteDataSource);
});

// Use case
final getProductsProvider = Provider<GetProducts>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return GetProducts(repo);
});

// FutureProvider for fetching products directly
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final getProducts = ref.watch(getProductsProvider);
  return await getProducts();
});
