import 'dart:io';

import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';
import '../models/update_profile_request.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource profileRemoteDatasource;

  const ProfileRepositoryImpl(this.profileRemoteDatasource);

  @override
  Future<bool> updateProfileImage(File file) {
    return profileRemoteDatasource.updateProfileImage(file);
  }

  @override
  Future<Profile> getProfile() async {
    final res = await profileRemoteDatasource.getProfile();
    return res.user; // Access the `user` field instead of `profile`
  }

  @override
  Future<bool> updateProfile(UpdateProfileRequest request) {
    return profileRemoteDatasource.updateProfile(request);
  }
}