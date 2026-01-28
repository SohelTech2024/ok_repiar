import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class MobileVerificationScreen extends StatefulWidget {
  const MobileVerificationScreen({super.key});

  @override
  State<MobileVerificationScreen> createState() => _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 375;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      body: SafeArea(
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


                SizedBox(height: isSmallScreen ? 20 : 32),

                // Header Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Mobile Verification'.customText(
                      style: isSmallScreen
                          ? CustomTextStyle.headlineMedium
                          : CustomTextStyle.displaySmall,
                      color: AppColors.professionalText,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: isSmallScreen ? 8 : 12),
                    'Please enter your mobile number to receive\nOTP'.customText(
                      style: isSmallScreen
                          ? CustomTextStyle.bodySmall
                          : CustomTextStyle.bodyMedium,
                      color: const Color(0xFF5D4037),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),

                SizedBox(height: isSmallScreen ? 32 : 48),

                // Verification Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isSmallScreen ? 20 : 28),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: isSmallScreen ? 12 : 16),
                          PhoneTextField(
                            controller: _phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your mobile number';
                              }
                              if (value.length < 10) {
                                return 'Please enter a valid 10-digit mobile number';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              // Format phone number if needed
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: isSmallScreen ? 24 : 32),

                      // Send OTP Button
                      CustomButton(
                        text: 'SEND OTP',
                        onPressed: _sendOtp,
                        isLoading: _isLoading,
                        height: isSmallScreen ? 50 : 58,
                        variant: ButtonVariant.gradient,
                      ),

                      SizedBox(height: isSmallScreen ? 16 : 20),

                      // Additional Info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: isSmallScreen ? 16 : 18,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 8),
                          'We\'ll send you a 6-digit verification code'.customText(
                            style: isSmallScreen
                                ? CustomTextStyle.bodySmall
                                : CustomTextStyle.bodyMedium,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isSmallScreen ? 24 : 32),

                // Terms & Privacy
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                  constraints: BoxConstraints(
                    maxWidth: isLargeScreen ? 500 : double.infinity,
                  ),
                  margin: isLargeScreen
                      ? EdgeInsets.symmetric(horizontal: (screenWidth - 500) / 2)
                      : null,
                  child: Column(
                    children: [
                      'By continuing, you agree to our'.customText(
                        style: isSmallScreen
                            ? CustomTextStyle.bodySmall
                            : CustomTextStyle.bodyMedium,
                        color: const Color(0xFF5D4037),
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              // Navigate to terms screen
                            },
                            child: 'Terms of Service'.customText(
                              style: isSmallScreen
                                  ? CustomTextStyle.bodySmall
                                  : CustomTextStyle.bodyMedium,
                              color: AppColors.primaryDarkBlue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          ' and '.customText(
                            style: isSmallScreen
                                ? CustomTextStyle.bodySmall
                                : CustomTextStyle.bodyMedium,
                            color: const Color(0xFF5D4037),
                            fontWeight: FontWeight.w500,
                          ),
                          InkWell(
                            onTap: () {
                              // Navigate to privacy screen
                            },
                            child: 'Privacy Policy'.customText(
                              style: isSmallScreen
                                  ? CustomTextStyle.bodySmall
                                  : CustomTextStyle.bodyMedium,
                              color: AppColors.primaryDarkBlue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
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
    );
  }

  Future<void> _sendOtp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      Navigator.pushNamed(
        context,
        RouteNames.otpVerify,
        arguments: '7058143404', // Pass phone number as argument
      );

      // Navigate to OTP verification screen
      // Navigator.pushReplacementNamed(context, RouteNames.otpVerification);
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}