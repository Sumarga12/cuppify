import 'package:flutter/material.dart';

class OnboardingViewModel {
  void getStarted(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home'); // Replace '/home' with your route
  }
}
