import 'package:flutter/material.dart';
import 'package:ok_repair_app/providers/home_provider.dart';
import 'package:ok_repair_app/providers/subscription_provider.dart';
import 'package:provider/provider.dart';
import 'core/routing/app_router.dart';
import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart'; // Add this import
import 'ui/screens/splash/splash_screen.dart';
import 'ui/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider( // Change from ChangeNotifierProvider to MultiProvider
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => SubscriptionProvider()),// Add AuthProvider
        ChangeNotifierProvider(create: (context) => HomeProvider()),// Add AuthProvider
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Manage My Shoppe',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            onGenerateRoute: AppRouter.generateRoute,
          );
        },
      ),
    );
  }
}