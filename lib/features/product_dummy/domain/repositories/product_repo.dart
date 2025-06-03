import 'package:msc_suite_flutter_app/features/product_dummy/domain/entities/product.dart';

abstract class ProductRepositary{
  Future<List<Product>> getProducts();
}