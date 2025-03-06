import 'package:dio/dio.dart';
import 'package:ecommerce/app/shared_prefs/token_shared_prefs.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../domain/entity/auth_entity.dart';
import '../../model/auth_api_model.dart';
import '../auth_data_source.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<String> loginUser(String email, String password) async {
    try {

      var response = await _dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      // print("Reached here");

      if (response.statusCode == 200) {
        final str = response.data['token'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> registerUser(AuthEntity user) async {
    try {
      var userApiModel = AuthApiModel.fromEntity(user);
      var response = await _dio.post(
        ApiEndpoints.register,
        data: userApiModel.toJson(),
      );

      if (response.statusCode == 201) return response.data['token'];

      throw Exception(response.data['success']);
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthEntity> getUserByEmail(String email) {
    // TODO: implement getUserByEmail
    throw UnimplementedError();
  }

  @override
  Future<AuthEntity> getUserById(String userId) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<AuthEntity> updateUserPatch(String userId, Map<String, dynamic> updates) {
    // TODO: implement updateUserPatch
    throw UnimplementedError();
  }

  @override
  Future<AuthEntity> updateUserPut(String userId, AuthEntity user) {
    // TODO: implement updateUserPut
    throw UnimplementedError();
  }
}
