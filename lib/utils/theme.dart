import 'package:flutter/material.dart';

class AppTheme {
  // Premium Color Palette
  static const Color primaryColor = Color(0xFF4F46E5); // Indigo 600
  static const Color secondaryColor = Color(0xFF818CF8); // Indigo 400
  static const Color accentColor = Color(0xFFF472B6); // Pink 400
  static const Color darkBackground = Color(0xFF0F172A); // Slate 900
  static const Color lightBackground = Color(0xFFF8FAFC); // Slate 50
  
  static const Color textPrimary = Color(0xFF1E293B); // Slate 800
  static const Color textSecondary = Color(0xFF64748B); // Slate 500
  static const Color textLight = Colors.white;

  static const Color cardColor = Colors.white;
  static const Color borderColor = Color(0xFFE2E8F0); // Slate 200

  // Gradients
  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [Color(0xFF4338CA), Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get glassGradient => LinearGradient(
    colors: [Colors.white.withOpacity(0.9), Colors.white.withOpacity(0.6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows
  static BoxShadow get softShadow => BoxShadow(
    color: const Color(0xFF64748B).withOpacity(0.1),
    blurRadius: 16,
    offset: const Offset(0, 8),
    spreadRadius: -4,
  );

  static BoxShadow get strongShadow => BoxShadow(
    color: const Color(0xFF4F46E5).withOpacity(0.25),
    blurRadius: 20,
    offset: const Offset(0, 10),
    spreadRadius: -2,
  );
  
  static BoxShadow get cardShadow => BoxShadow(
    color: const Color(0xFF0F172A).withOpacity(0.05),
    blurRadius: 10,
    offset: const Offset(0, 4),
  );

  static BoxShadow get buttonShadow => BoxShadow(
    color: primaryColor.withOpacity(0.3),
    blurRadius: 8,
    offset: const Offset(0, 2),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: lightBackground,
      fontFamily: 'Inter', // Ensure you have this font or fallback to system sans-serif
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        surface: lightBackground,
        onSurface: textPrimary,
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w800,
          color: textPrimary,
          letterSpacing: -1.0,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: textSecondary,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textSecondary,
          height: 1.5,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: borderColor, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        prefixIconColor: textSecondary,
        hintStyle: const TextStyle(color: textSecondary),
      ),
      
      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}