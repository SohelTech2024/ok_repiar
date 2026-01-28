import 'package:flutter/material.dart';

class AppColors {
  // Professional Dark Blue Theme
  static const Color primaryDarkBlue = Color(0xFF0D1B4D);
  static const Color secondaryDarkBlue = Color(0xFF1A237E);
  static const Color accentBlue = Color(0xFF283593);
  static const Color darkBlue = Color(0xFF0A1135);
  static const Color buttonBlue = Color(0xFF0A1135);

  // Professional Cream & White Theme
  static const Color professionalBackground = Color(0xFFF8F9FA);
  static const Color professionalSurface = Color(0xFFFFFFFF);
  static const Color professionalCard = Color(0xFFFFFFFF);
  static const Color professionalText = Color(0xFF2D3748);
  static const Color professionalSubtext = Color(0xFF718096);

  // Gradients
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFF0D1B4D), Color(0xFF1A237E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFF8F9FA), Color(0xFFE2E8F0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Text Colors
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textGrey = Color(0xFF666666);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkText = Color(0xFFFFFFFF);

  // Add these new colors:
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color errorRed = Color(0xFFF44336);
}