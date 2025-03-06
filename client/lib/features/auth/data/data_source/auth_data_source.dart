
import '../../domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String email, String password);

  Future<String> registerUser(AuthEntity user);

  Future<AuthEntity> getUserById(String userId);

  Future<AuthEntity> getUserByEmail(String email);

  Future<AuthEntity> updateUserPut(String userId, AuthEntity user);

  Future<AuthEntity> updateUserPatch(String userId, Map<String, dynamic> updates);
}
