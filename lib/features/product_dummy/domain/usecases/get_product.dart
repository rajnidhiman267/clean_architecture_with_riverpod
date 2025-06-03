import 'package:msc_suite_flutter_app/features/product_dummy/domain/entities/product.dart';
import 'package:msc_suite_flutter_app/features/product_dummy/domain/repositories/product_repo.dart';

class GetProducts {
  final ProductRepositary productRepositary;

  GetProducts(this.productRepositary);

  Future<List<Product>> call() async {
    return await productRepositary.getProducts();
  }
}
