import 'package:flutter/material.dart';
import 'views/splash_screen.dart';
import 'views/onboarding_screen.dart';
import 'views/signup_screen.dart';
import 'views/login_screen.dart';
import 'views/dashboard_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cuppify',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(), // Add Dashboard route
      },
    );
  }
}
  