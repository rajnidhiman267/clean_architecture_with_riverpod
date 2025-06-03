// data/repositories_impl/product_repository_impl.dart
import 'package:msc_suite_flutter_app/features/product_dummy/data/datasource/product_remote_datasource.dart';
import 'package:msc_suite_flutter_app/features/product_dummy/domain/repositories/product_repo.dart';

import '../../domain/entities/product.dart';

class ProductRepositoryImpl implements ProductRepositary {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getProducts() {
    return remoteDataSource.fetchProducts();
  }
}
