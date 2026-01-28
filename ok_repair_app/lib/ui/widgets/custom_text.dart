import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

enum CustomTextStyle {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineMedium,
  headlineSmall,
  titleLarge,
  bodyLarge,
  bodyMedium,
  bodySmall,
  button,
  caption,
}

class CustomText extends StatelessWidget {
  final String text;
  final CustomTextStyle style;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? letterSpacing;
  final double? height;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? decorationThickness;

  const CustomText({
    super.key,
    required this.text,
    this.style = CustomTextStyle.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.height,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = _getTextStyle(context);

    return Text(
      text,
      style: textStyle.copyWith(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        height: height,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    final theme = Theme.of(context);

    switch (style) {
      case CustomTextStyle.displayLarge:
        return theme.textTheme.displayLarge ?? const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 32,
          fontWeight: FontWeight.w700,
        );
      case CustomTextStyle.displayMedium:
        return theme.textTheme.displayMedium ?? const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 28,
          fontWeight: FontWeight.w700,
        );
      case CustomTextStyle.displaySmall:
        return theme.textTheme.displaySmall ?? const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
          fontWeight: FontWeight.w600,
        );
      case CustomTextStyle.headlineMedium:
        return theme.textTheme.headlineMedium ?? const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        );
      case CustomTextStyle.headlineSmall:
        return theme.textTheme.headlineSmall ?? const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        );
      case CustomTextStyle.titleLarge:
        return theme.textTheme.titleLarge ?? const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        );
      case CustomTextStyle.bodyLarge:
        return theme.textTheme.bodyLarge ?? const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        );
      case CustomTextStyle.bodyMedium:
        return theme.textTheme.bodyMedium ?? const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400,
        );
      case CustomTextStyle.bodySmall:
        return theme.textTheme.bodySmall ?? const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w400,
        );
      case CustomTextStyle.button:
        return const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        );
      case CustomTextStyle.caption:
        return const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w400,
        );
    }
  }
}

// Extension for easy usage
extension CustomTextExtension on String {
  Widget customText({
    CustomTextStyle style = CustomTextStyle.bodyMedium,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    double? height,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
  }) {
    return CustomText(
      text: this,
      style: style,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontWeight: fontWeight,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      height: height,
      fontStyle: fontStyle,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }
}