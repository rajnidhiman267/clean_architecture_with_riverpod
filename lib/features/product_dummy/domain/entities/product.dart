// domain/entities/product.dart
abstract class Product {
  int get id;
  int get userId;
  String get title;
  bool get completed;
}
