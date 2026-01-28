import 'package:flutter/material.dart';
import 'package:ok_repair_app/ui/screens/auth/mobile_verify_screen.dart';
import '../../ui/screens/auth/login_screen.dart';
import '../../ui/screens/auth/otp_verify_screen.dart';
import '../../ui/screens/auth/signup_screen.dart';
import '../../ui/screens/home/home_screen.dart';
import '../../ui/screens/intro/intro_screen.dart';
import '../../ui/screens/splash/splash_screen.dart';
import '../../ui/screens/subscription/subscription_purchase_screen.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.intro:
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteNames.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.mobileVerify:
        return MaterialPageRoute(
            builder: (_) => const MobileVerificationScreen());
      case RouteNames.purchaseSubscription:
        return MaterialPageRoute(
            builder: (_) => const PurchaseSubscriptionScreen());
      case RouteNames.otpVerify:
        final args = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => OTPVerificationScreen(
            phoneNumber: args ?? '',
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
