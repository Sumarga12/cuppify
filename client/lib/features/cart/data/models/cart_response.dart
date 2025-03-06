import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_items.dart';

class CartResponse {
  final bool success;
  final CartData data;

  CartResponse({
    required this.success,
    required this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      success: json['success'],
      data: CartData.fromJson(json['data']),
    );
  }
}

class CartData {
  final Cart cart;
  final List<CartItemData> cartItems;

  CartData({
    required this.cart,
    required this.cartItems,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      cart: Cart.fromJson(json),
      cartItems: List<CartItemData>.from(
          json['cartItems'].map((x) => CartItemData.fromJson(x))),
    );
  }
}