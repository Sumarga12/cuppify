
import '../../data/models/product_request.dart';
import '../../data/models/review_request.dart';
import '../entities/product.dart';
import '../entities/review.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts(ProductRequest request);
  Future<bool> writeReviews(ReviewRequest request);
  Future<List<Review>> getReviews(String productId);
}
