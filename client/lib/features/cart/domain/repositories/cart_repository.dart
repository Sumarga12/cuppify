
import '../../data/models/add_cart_request.dart';
import '../../data/models/cart_request.dart';
import '../../data/models/cart_response.dart';
import '../../data/models/update_cart_request.dart';

abstract class CartRepository {
  Future<String> updateCart(UpdateCartRequest request);
  Future<bool> addToCart(AddCartRequest cartRequest);
  Future<CartData> getCart(CartRequest cartRequest);
}
