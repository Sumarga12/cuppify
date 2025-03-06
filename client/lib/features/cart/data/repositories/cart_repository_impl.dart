
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_datasource.dart';
import '../models/add_cart_request.dart';
import '../models/cart_request.dart';
import '../models/cart_response.dart';
import '../models/update_cart_request.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDatasource remoteDatasource;

  CartRepositoryImpl({required this.remoteDatasource});

  @override
  Future<CartData> getCart(CartRequest cartRequest) async {
    final res = await remoteDatasource.getCart(cartRequest);

    return res.data;
  }

  @override
  Future<String> updateCart(UpdateCartRequest request) {
    return remoteDatasource.updateCart(request);
  }

  @override
  Future<bool> addToCart(AddCartRequest cartRequest) {
    return remoteDatasource.addToCart(cartRequest);
  }
}
