import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import '../../../providers/auth_provider.dart'; // Import your auth provider

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 375;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF9C4), // Light Yellow
              Color(0xFFFFF59D), // Medium Yellow
              Color(0xFFFFF176), // Bright Yellow
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16 : 24,
              vertical: isSmallScreen ? 16 : 24,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  CustomBackButton(
                    onPressed: () => Navigator.pop(context),
                    backgroundColor: AppColors.professionalSurface,
                    iconColor: AppColors.primaryDarkBlue,
                    width: 44,
                    height: 44,
                    borderRadius: 16,
                    iconSize: 20,
                    shadowColor: AppColors.primaryDarkBlue,
                    shadowBlur: 12,
                    shadowOffset: const Offset(0, 4),
                    padding: const EdgeInsets.all(10),
                  ),

                  SizedBox(height: isSmallScreen ? 16 : 20),

                  // Welcome Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Welcome Back!'.customText(
                        style: isSmallScreen
                            ? CustomTextStyle.headlineSmall
                            : CustomTextStyle.displaySmall,
                        color: AppColors.professionalText,
                        fontWeight: FontWeight.w800,
                      ),
                      SizedBox(height: isSmallScreen ? 4 : 8),
                      'Login to your OK Repair account'.customText(
                        style: isSmallScreen
                            ? CustomTextStyle.bodySmall
                            : CustomTextStyle.bodyMedium,
                        color: const Color(0xFF5D4037),
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),

                  SizedBox(height: isSmallScreen ? 24 : 40),

                  // Login Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
                    constraints: BoxConstraints(
                      maxWidth: isLargeScreen ? 500 : double.infinity,
                    ),
                    margin: isLargeScreen
                        ? EdgeInsets.symmetric(horizontal: (screenWidth - 500) / 2)
                        : null,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 25,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Phone Number Field
                        PhoneTextField(
                          controller: _phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (value.length < 10) {
                              return 'Please enter a valid 10-digit phone number';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            // Format phone number if needed
                          },
                        ),

                        SizedBox(height: isSmallScreen ? 16 : 20),

                        // Password Field
                        PasswordTextField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            // Handle password changes
                          },
                        ),

                        SizedBox(height: isSmallScreen ? 12 : 16),

                        // Remember Me & Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Remember Me
                            Row(
                              children: [
                                Container(
                                  width: isSmallScreen ? 18 : 20,
                                  height: isSmallScreen ? 18 : 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: AppColors.primaryDarkBlue.withOpacity(0.6),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Theme(
                                    data: ThemeData(
                                      unselectedWidgetColor: Colors.transparent,
                                    ),
                                    child: Checkbox(
                                      value: _rememberMe,
                                      onChanged: (value) {
                                        setState(() {
                                          _rememberMe = value!;
                                        });
                                      },
                                      activeColor: AppColors.primaryDarkBlue,
                                      checkColor: Colors.white,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: isSmallScreen ? 6 : 8),
                                'Remember me'.customText(
                                  style: isSmallScreen
                                      ? CustomTextStyle.bodySmall
                                      : CustomTextStyle.bodyMedium,
                                  color: const Color(0xFF5D4037),
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),

                            // Forgot Password
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteNames.home);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                              ),
                              child: 'Forgot Password?'.customText(
                                style: isSmallScreen
                                    ? CustomTextStyle.bodySmall
                                    : CustomTextStyle.bodyMedium,
                                color: AppColors.primaryDarkBlue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: isSmallScreen ? 20 : 24),

                        // Login Button
                        CustomButton(
                          text: 'LOGIN SECURELY',
                          onPressed: () => _login(authProvider),
                          isLoading: authProvider.isLoading,
                          height: isSmallScreen ? 50 : 58,
                          variant: ButtonVariant.gradient,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 20 : 24),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                    constraints: BoxConstraints(
                      maxWidth: isLargeScreen ? 500 : double.infinity,
                    ),
                    margin: isLargeScreen
                        ? EdgeInsets.symmetric(horizontal: (screenWidth - 500) / 2)
                        : null,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: AppColors.primaryDarkBlue.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.mobileVerify);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                '+ Register New Shop'.customText(
                                  style: isSmallScreen
                                      ? CustomTextStyle.bodyMedium
                                      : CustomTextStyle.bodyLarge,
                                  color: AppColors.primaryDarkBlue,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: isSmallScreen ? 16 : 18,
                                  color: AppColors.primaryDarkBlue,
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: isSmallScreen ? 8 : 12),

                        // Divider
                        Divider(
                          color: AppColors.primaryDarkBlue.withOpacity(0.2),
                          thickness: 1,
                          height: 1,
                        ),

                        SizedBox(height: isSmallScreen ? 8 : 12),

                        // Forgot Password Text
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.home);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                'Forgot Password?'.customText(
                                  style: isSmallScreen
                                      ? CustomTextStyle.bodyMedium
                                      : CustomTextStyle.bodyLarge,
                                  color: AppColors.primaryDarkBlue,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.lock_reset_rounded,
                                  size: isSmallScreen ? 16 : 18,
                                  color: AppColors.primaryDarkBlue,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Add some bottom padding for better scrolling
                  SizedBox(height: isSmallScreen ? 20 : 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login(AuthProvider authProvider) async {
    if (_formKey.currentState!.validate()) {
      final success = await authProvider.login(
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
        rememberMe: _rememberMe,
      );

      if (success && mounted) {
        Navigator.pushReplacementNamed(context, RouteNames.home);
      }
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}