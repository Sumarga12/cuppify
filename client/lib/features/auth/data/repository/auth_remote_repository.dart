import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/internet_checker.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_data_source.dart';

class AuthRemoteRepository implements IAuthRepository {
  final InternetChecker internetChecker;
  final IAuthDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource, this.internetChecker);

  // @override
  // Future<Either<Failure, List<String>>> loginUser(String email, String password) async {
  //   if (!await internetChecker.isConnected) return Left(NoInternetFailure());
  //
  //   try {
  //     // Call the login function from the remote data source
  //     final response = await _authRemoteDataSource.loginUser(email, password);
  //
  //     // Return the response directly (it's already a List<String>)
  //     return Right(response);
  //   } catch (e) {
  //     // Handle any errors and return the failure message
  //     return Left(
  //       ApiFailure(
  //         message: 'Login Failed: $e',
  //       ),
  //     );
  //   }
  // }

  @override
  Future<Either<Failure, String>> registerUser(AuthEntity user) async {
    if (!await internetChecker.isConnected) return Left(NoInternetFailure());

    try {
      final res = await _authRemoteDataSource.registerUser(user);
      return Right(res);
    } catch (e) {
      return Left(ApiFailure(message: e.toString().replaceAll('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(String email, String password) async {
    try {
      // Call the login function from the remote data source
      final response = await _authRemoteDataSource.loginUser(email, password);

      // Return the response directly (it's already a List<String>)
      return Right(response);
    } catch (e) {
      // Handle any errors and return the failure message
      return Left(
        ApiFailure(
          message: 'Login Failed: $e',
        ),
      );
    }
  }
}
