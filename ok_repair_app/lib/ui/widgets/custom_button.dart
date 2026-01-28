import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

enum ButtonVariant { primary, secondary, outlined, gradient }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final bool isLoading;
  final double width;
  final double height;
  final Widget? icon;
  final bool expanded;
  final LinearGradient? gradient; // Custom gradient override
  final Color? backgroundColor; // Custom background color override
  final Color? textColor; // Custom text color override
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 56,
    this.icon,
    this.expanded = true,
    this.gradient,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final bool isGradientVariant = variant == ButtonVariant.gradient;

    // For gradient variant, we need to wrap with a container
    if (isGradientVariant) {
      return _buildGradientButton(context);
    }

    return SizedBox(
      width: expanded ? width : null,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(context),
        child: _buildButtonContent(context),
      ),
    );
  }

  Widget _buildGradientButton(BuildContext context) {
    return Container(
      width: expanded ? width : null,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.buttonGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDarkBlue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: textColor ?? _getTextColor(context),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: _buildButtonContent(context),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    return isLoading
        ? SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: _getProgressIndicatorColor(context),
      ),
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: textColor ?? _getTextColor(context),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final baseStyle = ElevatedButton.styleFrom(
      foregroundColor: textColor ?? _getTextColor(context),
      elevation: _getElevation(),
      shadowColor: _getShadowColor(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: _getBorderSide(),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
    );

    // Apply background color only for non-gradient variants
    if (variant != ButtonVariant.gradient) {
      return baseStyle.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return _getDisabledColor(context);
            }
            return backgroundColor ?? _getBackgroundColor(context);
          },
        ),
      );
    }

    return baseStyle;
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.buttonBlue;
      case ButtonVariant.secondary:
        return AppColors.professionalSurface;
      case ButtonVariant.outlined:
      case ButtonVariant.gradient:
        return Colors.transparent;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.gradient:
        return AppColors.textLight;
      case ButtonVariant.secondary:
      case ButtonVariant.outlined:
        return AppColors.primaryDarkBlue;
    }
  }

  Color _getProgressIndicatorColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.gradient:
        return AppColors.textLight;
      case ButtonVariant.secondary:
      case ButtonVariant.outlined:
        return AppColors.primaryDarkBlue;
    }
  }

  Color _getDisabledColor(BuildContext context) {
    return AppColors.textGrey.withOpacity(0.5);
  }

  double _getElevation() {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.gradient:
        return 4;
      case ButtonVariant.secondary:
        return 2;
      case ButtonVariant.outlined:
        return 0;
    }
  }

  Color _getShadowColor() {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.gradient:
        return AppColors.primaryDarkBlue.withOpacity(0.3);
      case ButtonVariant.secondary:
      case ButtonVariant.outlined:
        return Colors.transparent;
    }
  }

  BorderSide _getBorderSide() {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.gradient:
        return BorderSide.none;
      case ButtonVariant.secondary:
      case ButtonVariant.outlined:
        return const BorderSide(
          color: AppColors.primaryDarkBlue,
          width: 1.5,
        );
    }
  }
}

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final double width;
  final double height;
  final double borderRadius;
  final double iconSize;
  final bool showShadow;
  final Color shadowColor;
  final double shadowBlur;
  final Offset shadowOffset;
  final EdgeInsetsGeometry padding;

  const CustomBackButton({
    super.key,
    this.onPressed,
    this.backgroundColor = Colors.white,
    this.iconColor = AppColors.primaryDarkBlue,
    this.width = 40,
    this.height = 40,
    this.borderRadius = 12,
    this.iconSize = 18,
    this.showShadow = true,
    this.shadowColor = Colors.black,
    this.shadowBlur = 8,
    this.shadowOffset = const Offset(0, 2),
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.pop(context),
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: showShadow
              ? [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              blurRadius: shadowBlur,
              offset: shadowOffset,
            ),
          ]
              : null,
        ),
        child: Icon(
          Icons.arrow_back_ios_rounded,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  final bool showBadge;
  final int badgeCount;
  final String? badgeText;
  final Color? badgeColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool showShadow;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor = Colors.white,
    this.iconColor = AppColors.primaryDarkBlue,
    this.size = 40,
    this.iconSize = 20,
    this.showBadge = false,
    this.badgeCount = 0,
    this.badgeText,
    this.badgeColor = Colors.red,
    this.padding = const EdgeInsets.all(8),
    this.borderRadius = 12,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main Icon Button
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: showShadow
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(borderRadius),
              child: Padding(
                padding: padding,
                child: Icon(
                  icon,
                  size: iconSize,
                  color: iconColor,
                ),
              ),
            ),
          ),
        ),

        // Badge
        if (showBadge && (badgeCount > 0 || badgeText != null))
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: badgeColor ?? Colors.red,
                shape: BoxShape.circle,
                border: Border.all(
                  color: backgroundColor,
                  width: 2,
                ),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                badgeText ?? (badgeCount > 9 ? '9+' : badgeCount.toString()),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

// Specialized variants for common use cases
class AppBarIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final bool showBadge;
  final int badgeCount;
  final Color backgroundColor;
  final Color iconColor;

  const AppBarIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.showBadge = false,
    this.badgeCount = 0,
    this.backgroundColor = Colors.white,
    this.iconColor = AppColors.primaryDarkBlue,
  });

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: onPressed,
      icon: icon,
      backgroundColor: backgroundColor,
      iconColor: iconColor,
      size: 40,
      iconSize: 20,
      showBadge: showBadge,
      badgeCount: badgeCount,
      padding: const EdgeInsets.all(8),
      borderRadius: 12,
      showShadow: false,
    );
  }
}

// Transparent variant for app bars
class TransparentIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final bool showBadge;
  final int badgeCount;
  final Color iconColor;
  final double opacity;

  const TransparentIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.showBadge = false,
    this.badgeCount = 0,
    this.iconColor = Colors.white,
    this.opacity = 0.15,
  });

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: onPressed,
      icon: icon,
      backgroundColor: Colors.white.withOpacity(opacity),
      iconColor: iconColor,
      size: 40,
      iconSize: 20,
      showBadge: showBadge,
      badgeCount: badgeCount,
      padding: const EdgeInsets.all(8),
      borderRadius: 12,
      showShadow: false,
    );
  }
}