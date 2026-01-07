import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ProblemPlatformApp());
}

class ProblemPlatformApp extends StatelessWidget {
  const ProblemPlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainLift',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}