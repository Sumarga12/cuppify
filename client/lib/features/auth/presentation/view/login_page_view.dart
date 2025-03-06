import 'package:ecommerce/features/auth/presentation/view/signup_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/di.dart';
import '../../../home/presentation/home_view.dart';
import '../view_model/login/bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  bool isPasswordVisible = false; // Track password visibility

  void _loginUser(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Dispatch LoginUserEvent
      context.read<LoginBloc>().add(
            LoginUserEvent(
              context: context,
              email: emailController.text,
              password: passwordController.text,
              destination:
                  DashboardPageView(), // Replace with your actual home/dashboard widget
            ),
          );
    }
  }

  void _togglePasswordVisibility(BuildContext context) {
    // Dispatch TogglePasswordVisibilityEvent
    context.read<LoginBloc>().add(TogglePasswordVisibilityEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: Builder(builder: (context) {
        return BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              // Navigate to home/dashboard on success
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DashboardPageView()),
              );
            }
          },
          child: Scaffold(
            // Changed background color to white
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 800,
                        left: -50,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.green,
                        ),
                      ),
                      Positioned(
                        top: -100,
                        left: -50,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.green,
                        ),
                      ),
                      Positioned(
                        top: -50,
                        right: -50,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.green,
                        ),
                      ),
                      Positioned(
                        top: 800,
                        right: -50,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.green,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 60.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/logo.png', height: 200),
                            const SizedBox(height: 50),
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    key: const Key('email'),
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      labelText: 'E-mail',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      final emailRegex = RegExp(
                                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}");
                                      if (!emailRegex.hasMatch(value)) {
                                        return "Enter a valid email";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  BlocBuilder<LoginBloc, LoginState>(
                                    builder: (context, state) {
                                      return TextFormField(
                                        key: const Key('password'),
                                        controller: passwordController,
                                        obscureText: !state
                                            .isPasswordVisible, // Toggle visibility
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              state.isPasswordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                            onPressed: () =>
                                                _togglePasswordVisibility(
                                                    context),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          if (value.length < 6) {
                                            return 'Password must be at least 6 characters';
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 15),
                                  ),
                                  onPressed: state.isLoading
                                      ? null // Disable button when loading
                                      : () => _loginUser(context),
                                  child: state.isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white)
                                      : const Text(
                                          key: ValueKey('loginButton'),
                                          'LOGIN',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                );
                              },
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account?"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()),
                                    );
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
