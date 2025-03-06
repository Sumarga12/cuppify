import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/update_cart_request.dart';
import '../repositories/cart_repository.dart';

class UpdateCart implements UsecaseWithParams<String, UpdateCartRequest> {
  final CartRepository repository;
  const UpdateCart(this.repository);

  @override
  Future<Either<Failure, String>> call(UpdateCartRequest request) async {
    try {
      final response = await repository.updateCart(request);
      return Right(response);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
