class UpdateCartRequest {
  final String userId;
  final String cartitem;
  final int quantity;

  UpdateCartRequest({
    required this.userId,
    required this.cartitem,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'cartitem': cartitem,
      'quantity': quantity,
    };
  }

  // @override
  // String toString() => 'UpdateCartRequest(cartitem: $cartitem, quantity: $quantity)';
}
