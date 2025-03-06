class AddCartRequest {
  final String userId;
  final String item;
  final int quantity;

  AddCartRequest({
    required this.userId,
    required this.item,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'item': item,
      'quantity': quantity,
    };
  }

  //
  // @override
  // String toString() => 'AddCartRequest(item: $item, quantity: $quantity)';
}
