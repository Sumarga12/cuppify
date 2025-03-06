import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/cart_request.dart';
import '../../data/models/cart_response.dart';
import '../repositories/cart_repository.dart';

class FetchCart implements UsecaseWithParams<CartData, CartRequest> {
  final CartRepository repository;
  const FetchCart(this.repository);

  @override
  Future<Either<Failure, CartData>> call(CartRequest request) async {
    try {
      final response = await repository.getCart(request);
      return Right(response);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}