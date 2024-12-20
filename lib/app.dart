import 'package:cuppify/core/app_theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'views/dashboard_screen.dart';
import 'views/login_screen.dart';
import 'views/onboarding_screen.dart';
import 'views/signup_screen.dart';
import 'views/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cuppify',
      theme: getApplicationTheme(),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(), // Add Dashboard route
      },
    );
  }
}
