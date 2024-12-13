import 'package:flutter/material.dart';

class SplashViewModel {
  void navigateToNextScreen(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding'); // Adjust route
    });
  }
}
