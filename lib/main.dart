import 'package:flutter/material.dart';

import 'screens/signup_screen.dart';

void main() => runApp(const SignUpApp());

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF6C4CF1),
        fontFamily: 'Inter',
      ),
      home: const SignUpScreen(),
    );
  }
}
