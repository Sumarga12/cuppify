import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../models/profile_response.dart';
import '../models/update_profile_request.dart';

abstract class ProfileRemoteDatasource {
  Future<ProfileResponse> getProfile();
  Future<bool> updateProfile(UpdateProfileRequest request);
  Future<bool> updateProfileImage(File file);
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final Dio dio;
  final TokenSharedPrefs tokenSharedPrefs;

  ProfileRemoteDatasourceImpl({required this.dio, required this.tokenSharedPrefs});


  @override
  Future<ProfileResponse> getProfile() async {
    final userId = await tokenSharedPrefs.getUserId();
    if (userId == null) {
      throw Exception('User not logged in');
    }

    final response = await dio.get('${ApiEndpoints.profile}$userId');
    if (response.statusCode == 200) {
      return ProfileResponse.fromJson(response.data);
    }
    throw Exception('Failed to load profile');
  }
  @override
  Future<bool> updateProfile(UpdateProfileRequest request) async {
    try {
      final response = await dio.patch('${ApiEndpoints.updateProfile}/${request.userId}', data: request.toJson());
      if (response.statusCode == 200) return true;
      throw Exception('Failed to update profile');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> updateProfileImage(File file) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(file.path, contentType: DioMediaType.parse('image/jpeg')),
      });
      final response = await dio.put(ApiEndpoints.uploadPP, data: formData);
      if (response.statusCode == 200) return true;
      throw Exception('Failed to update profile image');
    } catch (e) {
      throw Exception(e);
    }
  }
}
