class CartItemData {
  final String id;
  final Product product;
  final num price;
  final int quantity;

  CartItemData({
    required this.id,
    required this.product,
    required this.price,
    required this.quantity,
  });

  factory CartItemData.fromJson(Map<String, dynamic> json) {
    return CartItemData(
      id: json['_id'],
      product: Product.fromJson(json['product']),
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}

class Product {
  final String id;
  final String name;
  final num price;
  final String? images;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      price: json['price'],
      images: json['images'],
    );
  }
}