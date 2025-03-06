
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/products_remote_datasource.dart';
import '../models/product_request.dart';
import '../models/review_request.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductsRemoteDatasource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts(ProductRequest request) async {
    try {
      final products = await remoteDataSource.getProducts(request);
      return products.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Review>> getReviews(String productId) async {
    try {
      final products = await remoteDataSource.getReviews(productId);
      return products.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> writeReviews(ReviewRequest request) {
    try {
      return remoteDataSource.writeReview(request);
    } catch (e) {
      rethrow;
    }
  }
}
