import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'theme.dart';

void main() {
  runApp(const ProblemPlatformApp());
}

class ProblemPlatformApp extends StatelessWidget {
  const ProblemPlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Problem Platform',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}