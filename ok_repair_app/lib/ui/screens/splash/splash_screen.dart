import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../../providers/theme_provider.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pushReplacementNamed(context, RouteNames.intro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo/Icon with professional design
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primaryDarkBlue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryDarkBlue.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.build_circle_rounded,
                  size: 50,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 32),

              // App Name with professional typography
              Column(
                children: [
                  'OK Repair'.customText(
                    style: CustomTextStyle.displayMedium,
                    color: AppColors.primaryDarkBlue,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                  const SizedBox(height: 8),
                  'Smart Mobile Repair Management'.customText(
                    style: CustomTextStyle.bodyMedium,
                    color: AppColors.professionalSubtext,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 60),

              // Loading Indicator
              const CustomLoadingIndicator(
                size: 32,
                color: AppColors.primaryDarkBlue,
              ),

              const SizedBox(height: 20),

              'Initializing...'.customText(
                style: CustomTextStyle.bodyMedium,
                color: AppColors.professionalSubtext,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}