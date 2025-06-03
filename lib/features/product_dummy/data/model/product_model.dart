// lib/features/product_dummy/data/model/product_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@Freezed(fromJson: true, toJson: true)
abstract class ProductModel with _$ProductModel implements Product {
  // Added constructor. Must not have any parameter
  const ProductModel._();
  const factory ProductModel({
    required int userId,
    required int id,
    required String title,
    required bool completed,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  
}
