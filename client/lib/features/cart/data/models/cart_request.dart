class CartRequest {
  final String userId;
  final int page;
  final int limit;

  CartRequest({
    required this.userId,
    this.page = 1,
    this.limit = 50,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'page': page,
      'limit': limit,
    };
  }
}