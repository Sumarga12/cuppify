import '../../domain/entities/profile.dart';

class ProfileResponse {
  final bool success;
  final Profile user;

  ProfileResponse({
    required this.success,
    required this.user,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      success: json['success'],
      user: Profile.fromJson(json['user']),
    );
  }

  Profile toEntity() {
    return user;
  }
}