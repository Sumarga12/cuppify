import 'package:dartz/dartz.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/failure.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      print('Saving Token: $token'); // Debugging
      await _sharedPreferences.setString('token', token);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }


  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      print('Retrieved Token: $token'); // Debugging
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<String?> getUserId() async {
    try {
      final token = _sharedPreferences.getString('token');
      print('Decoding Token: $token'); // Debugging

      if (token != null && token.isNotEmpty) {
        final payload = Jwt.parseJwt(token);
        print('Decoded Payload: $payload'); // Debugging
        return payload['id'] as String?;
      }
      return null;
    } catch (e) {
      print('Error Decoding Token: $e'); // Debugging
      return null;
    }
  }



  Future<void> clearToken() async {
    await _sharedPreferences.remove('token');
  }
}
