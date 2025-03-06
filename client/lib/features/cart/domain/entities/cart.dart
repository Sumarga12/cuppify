class Cart {
  final String id;
  final int cartNo;
  final String userId;
  final num total;
  final num discount;
  final num grandTotal;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Cart({
    required this.id,
    required this.cartNo,
    required this.userId,
    required this.total,
    required this.discount,
    required this.grandTotal,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['_id'],
      cartNo: json['cartNo'],
      userId: json['userId'],
      total: json['total'],
      discount: json['discount'],
      grandTotal: json['grandTotal'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}