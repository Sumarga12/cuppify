import 'package:flutter/material.dart';

import '../utils/constants.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top image section
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/coffee_cups.png', // Replace with your image
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.more_vert, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Text and button section
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.primaryColor,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Elevate your coffee experience at Cuppify',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Where coffee meets comfort.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
