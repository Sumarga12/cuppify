import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repository/auth_repository.dart';

class LoginUserParams extends Equatable {
  final String email;
  final String password;

  const LoginUserParams({
    required this.email,
    required this.password,
  });

  const LoginUserParams.empty()
      : email = '_empty.string',
        password = '_empty.string';

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class LoginUsecase implements UsecaseWithParams<void, LoginUserParams> {
  final IAuthRepository authRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUsecase({required this.authRepository, required this.tokenSharedPrefs});
  @override
  Future<Either<Failure, String>> call(LoginUserParams params) async {
    final result = await authRepository.loginUser(params.email, params.password);
    return result.fold(
          (failure) => Left(failure),
          (token) async {
        await tokenSharedPrefs.saveToken(token); // Ensure token is saved
        return Right(token);
      },
    );
  }
}