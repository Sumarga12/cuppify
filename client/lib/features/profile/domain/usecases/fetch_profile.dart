import 'package:dartz/dartz.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class FetchProfile implements UsecaseWithoutParams<Profile> {
  final ProfileRepository repository;

  FetchProfile(this.repository);

  @override
  Future<Either<Failure, Profile>> call() async {
    try {
      final res = await repository.getProfile();
      return Right(res);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
