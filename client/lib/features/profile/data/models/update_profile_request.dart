class UpdateProfileRequest {
  final String userId;
  final String name;
  final String phone;
  final String email;

  UpdateProfileRequest({
    required this.userId,
    required this.name,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}
