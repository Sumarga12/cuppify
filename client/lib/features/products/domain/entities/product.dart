
import '../../../../app/constants/api_endpoints.dart';

class Product {
  final String id;
  final String name;
  final String? sku;
  final num? calorieCount;
  final String description;
  final String? images;
  final String category;
  final num price;
  final num? rating;

  const Product({
    required this.id,
    required this.name,
    this.sku,
    this.calorieCount,
    required this.description,
    this.images,
    required this.category,
    required this.price,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      sku: json['sku'],
      calorieCount: json['calorie_count'],
      description: json['description'],
      images: '${ApiEndpoints.imageUrl}/${json['images']}',
      category: json['category'],
      price: json['price'],
      rating: json['rating'],
    );
  }
}

class Category {
  final String id;
  final String name;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final int v;

  const Category({
    required this.id,
    required this.name,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      isActive: json['is_active'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
