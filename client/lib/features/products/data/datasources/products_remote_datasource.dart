import 'package:dio/dio.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../models/product_request.dart';
import '../models/product_response.dart';
import '../models/review_request.dart';
import '../models/reviews_response.dart';

abstract class ProductsRemoteDatasource {
  Future<ProductResponse> getProducts(ProductRequest request);
  Future<bool> writeReview(ReviewRequest request);
  Future<ReviewResponse> getReviews(String productId);
}

class ProductsRemoteDatasourceImpl implements ProductsRemoteDatasource {
  final Dio dio;

  const ProductsRemoteDatasourceImpl(this.dio);

  @override
  Future<ProductResponse> getProducts(ProductRequest request) async {
    try {
      final response = await dio.get(ApiEndpoints.product, queryParameters: request.toJson());
      if (response.statusCode == 200) return ProductResponse.fromJson(response.data);
      throw Exception('Failed to load products');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> writeReview(ReviewRequest request) async {
    try {
      final response = await dio.post(ApiEndpoints.reviews, data: request.toJson());
      if (response.statusCode == 200) return response.data['success'];
      throw Exception('Failed to write reviews');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ReviewResponse> getReviews(String productId) async {
    try {
      final response = await dio.get('${ApiEndpoints.reviews}/$productId');
      if (response.statusCode == 200) return ReviewResponse.fromJson(response.data);
      throw Exception('Failed to load reviews');
    } catch (e) {
      throw Exception(e);
    }
  }
}
