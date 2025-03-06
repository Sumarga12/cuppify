import '../../domain/entities/product.dart';

class ProductResponse {
  ProductResponse({
    required this.success,
    required this.data,
  });

  final bool success;
  final List<Product> data;

  factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
    success: json["success"],
    data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
  );
}