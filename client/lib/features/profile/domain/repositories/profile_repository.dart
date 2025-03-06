import 'dart:io';

import '../../data/models/update_profile_request.dart';
import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
  Future<bool> updateProfile(UpdateProfileRequest request);
  Future<bool> updateProfileImage(File file);
}
