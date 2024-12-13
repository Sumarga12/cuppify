import 'package:flutter/material.dart';
import '../viewmodels/splash_viewmodel.dart';  // Import ViewModel

class SplashScreen extends StatelessWidget {
  final SplashViewModel viewModel = SplashViewModel(); // Instantiate ViewModel

  @override
  Widget build(BuildContext context) {
    viewModel.navigateToNextScreen(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity      ,
        color: Color(0xFF00A562), // Green background
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.coffee,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'CUPPIFY',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
