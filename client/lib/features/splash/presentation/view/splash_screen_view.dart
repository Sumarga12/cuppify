import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/cubit/splash_cubit.dart';
// import 'package:food_hub/features/splash/presentation/view_model/cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    context.read<SplashCubit>().init(context);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Center content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png', // Replace with actual logo path
                  height: screenHeight * 0.5, // 50% of screen height
                  width: screenWidth * 0.8, // 80% of screen width
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(), // Loading indicator
                const SizedBox(height: 10),
                // const Text('Version: 5.0.0'),
              ],
            ),
          ),
          // Footer
          // Positioned(
          //   bottom: 10,
          //   left: MediaQuery.of(context).size.width / 4,
          //   child: const Text(
          //     'Developed by: Sumarga Puri', // Replace with your name
          //     style: TextStyle(fontSize: 10),
          //   ),
          // ),
        ],
      ),
    );
  }
}
