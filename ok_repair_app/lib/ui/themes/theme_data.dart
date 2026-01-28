import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AppThemeData {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryDarkBlue,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryDarkBlue,
        secondary: AppColors.secondaryDarkBlue,
        background: AppColors.professionalBackground,
        surface: AppColors.professionalSurface,
        onPrimary: AppColors.textLight,
        onSecondary: AppColors.textLight,
        onBackground: AppColors.professionalText,
        onSurface: AppColors.professionalText,
      ),
      scaffoldBackgroundColor: AppColors.professionalBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryDarkBlue,
        foregroundColor: AppColors.textLight,
        elevation: 4,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textLight),
        shadowColor: Colors.black26,
      ),
      cardTheme: CardTheme(
        color: AppColors.professionalCard,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: Colors.black12,
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.professionalSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.professionalSubtext.withOpacity(0.2),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryDarkBlue,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        labelStyle: const TextStyle(
          color: AppColors.professionalSubtext,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
        hintStyle: const TextStyle(
          color: AppColors.professionalSubtext,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          fontFamily: 'Inter',
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColors.primaryDarkBlue,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
        errorStyle: const TextStyle(
          color: AppColors.error,
          fontWeight: FontWeight.w500,
          fontSize: 12,
          fontFamily: 'Inter',
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonBlue,
          foregroundColor: AppColors.textLight,
          elevation: 4,
          shadowColor: AppColors.primaryDarkBlue.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            letterSpacing: 0.5,
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.professionalText,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.professionalText,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.professionalText,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.professionalText,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.professionalText,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.professionalText,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.professionalText,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.professionalSubtext,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.professionalSubtext,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.professionalText,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDarkBlue,
      // ... dark theme configuration
    );
  }
}