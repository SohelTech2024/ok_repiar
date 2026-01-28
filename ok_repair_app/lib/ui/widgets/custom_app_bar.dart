import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final bool showLogo;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.onBackPressed,
    this.centerTitle = true,
    this.showLogo = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryDarkBlue,
      foregroundColor: AppColors.textLight,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.3),
      centerTitle: centerTitle,
      leading: showBackButton
          ? Container(
        margin: const EdgeInsets.only(left: 8),
        child: TransparentIconButton(
          onPressed: onBackPressed ?? () => Navigator.pop(context),
          icon: Icons.arrow_back_ios_rounded,
          iconColor: Colors.white,
        ),
      )
          : null,
      title: showLogo ? _buildLogoTitle() : _buildTextTitle(),
      actions: actions ?? _buildDefaultActions(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
    );
  }

  Widget _buildLogoTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo Icon
        CustomIconButton(
          onPressed: () {}, // Logo is not clickable
          icon: Icons.build_circle_rounded,
          backgroundColor: Colors.white,
          iconColor: AppColors.primaryDarkBlue,
          size: 36,
          iconSize: 22,
          borderRadius: 10,
          showShadow: true,
        ),
        const SizedBox(width: 12),
        // App Name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            'OK'.customText(
              style: CustomTextStyle.titleLarge,
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
            'Repair'.customText(
              style: CustomTextStyle.bodySmall,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextTitle() {
    return CustomText(
      text: title,
      style: CustomTextStyle.headlineSmall,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );
  }

  List<Widget> _buildDefaultActions() {
    return [
      // Notification Icon
      TransparentIconButton(
        onPressed: () {
          // Handle notifications
        },
        icon: Icons.notifications_none_rounded,
        showBadge: true,
        badgeCount: 3,
      ),
      const SizedBox(width: 8),

      // Menu Icon
      TransparentIconButton(
        onPressed: () {
          // Handle menu
        },
        icon: Icons.menu_rounded,
      ),
      const SizedBox(width: 12),
    ];
  }
}


// Specialized App Bar for Home Screen
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onProfilePressed;
  final int notificationCount;

  const HomeAppBar({
    super.key,
    this.onNotificationPressed,
    this.onMenuPressed,
    this.onProfilePressed,
    this.notificationCount = 0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryDarkBlue,
      foregroundColor: Colors.white,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.3),
      centerTitle: true,
      leading: Container(
        margin: const EdgeInsets.only(left: 12,top: 8),
        child: TransparentIconButton(
          onPressed: onMenuPressed!,
          icon: Icons.menu_rounded,
        ),
      ),
      title: _buildLogoTitle(),
      actions: [
        // Notification Button
        Container(
          margin: const EdgeInsets.only(right: 12),
          child: TransparentIconButton(
            onPressed: onNotificationPressed!,
            icon: Icons.notifications_none_rounded,
            showBadge: notificationCount > 0,
            badgeCount: notificationCount,
          ),
        ),

        // Menu Butto
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
    );
  }

  Widget _buildLogoTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo with gradient
        CustomIconButton(
          onPressed: () {}, // Logo is not clickable
          icon: Icons.build_circle_rounded,
          backgroundColor: Colors.white,
          iconColor: AppColors.primaryDarkBlue,
          size: 40,
          iconSize: 24,
          borderRadius: 12,
          showShadow: true,
        ),
        const SizedBox(width: 12),

        // App Name with better typography
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                'OK'.customText(
                  style: CustomTextStyle.headlineSmall,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  letterSpacing: -0.5,
                ),
                const SizedBox(width: 2),
                'Repair'.customText(
                  style: CustomTextStyle.titleLarge,
                  color: Colors.white.withOpacity(0.95),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ],
            ),
            'Business'.customText(
              style: CustomTextStyle.bodySmall,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ],
        ),
      ],
    );
  }
}

// App Bar for Authentication Screens
class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const AuthAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryDarkBlue,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: showBackButton
          ? Container(
        margin: const EdgeInsets.only(left: 8),
        child: TransparentIconButton(
          onPressed: onBackPressed ?? () => Navigator.pop(context),
          icon: Icons.arrow_back_ios_rounded,
          iconColor: Colors.white,
        ),
      )
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconButton(
            onPressed: () {}, // Logo is not clickable
            icon: Icons.build_rounded,
            backgroundColor: Colors.white,
            iconColor: AppColors.primaryDarkBlue,
            size: 32,
            iconSize: 18,
            borderRadius: 8,
          ),
          const SizedBox(width: 12),
          title.customText(
            style: CustomTextStyle.headlineSmall,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
    );
  }
}