import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _otpFocusNodes =
      List.generate(4, (index) => FocusNode());
  int _resendTimer = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_otpFocusNodes[0]);
    });
  }

  void _startResendTimer() {
    _resendTimer = 30;
    _canResend = false;
    setState(() {});

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _resendTimer--;
        });
        if (_resendTimer > 0) {
          _startResendTimer();
        } else {
          setState(() {
            _canResend = true;
          });
        }
      }
    });
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      _otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }
  }

  String get _enteredOtp {
    return _otpControllers.map((controller) => controller.text).join();
  }

  Future<void> _verifyOtp() async {
    if (_enteredOtp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: 'Please enter complete 4-digit OTP'.customText(
            style: CustomTextStyle.bodyMedium,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.verifyOTP(
      phoneNumber: widget.phoneNumber,
      otp: _enteredOtp,
    );

    if (success) {
      Navigator.pushReplacementNamed(context, RouteNames.signup);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: authProvider.error!.customText(
            style: CustomTextStyle.bodyMedium,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _resendOtp() async {
    if (!_canResend) return;

    setState(() {
      _canResend = false;
    });

    // Clear OTP fields
    for (var controller in _otpControllers) {
      controller.clear();
    }
    FocusScope.of(context).requestFocus(_otpFocusNodes[0]);

    // Start resend timer
    _startResendTimer();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.sendOTP(phoneNumber: widget.phoneNumber);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: 'OTP sent successfully'.customText(
            style: CustomTextStyle.bodyMedium,
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: authProvider.error!.customText(
            style: CustomTextStyle.bodyMedium,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
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
                    'Please enter the 4-digit code sent to your\nmobile number'
                        .customText(
                      style: isSmallScreen
                          ? CustomTextStyle.bodySmall
                          : CustomTextStyle.bodyMedium,
                      color: const Color(0xFF5D4037),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),

                SizedBox(height: isSmallScreen ? 24 : 32),

                // Phone Number Display
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDarkBlue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryDarkBlue.withOpacity(0.1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone_iphone_rounded,
                        size: 20,
                        color: AppColors.primaryDarkBlue,
                      ),
                      SizedBox(width: 8),
                      widget.phoneNumber.customText(
                        style: CustomTextStyle.headlineSmall,
                        color: AppColors.primaryDarkBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isSmallScreen ? 32 : 48),

                // OTP Verification Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isSmallScreen ? 20 : 28),
                  constraints: BoxConstraints(
                    maxWidth: isLargeScreen ? 500 : double.infinity,
                  ),
                  margin: isLargeScreen
                      ? EdgeInsets.symmetric(
                          horizontal: (screenWidth - 500) / 2)
                      : null,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(isSmallScreen ? 20 : 24),
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
                      // OTP Input Fields
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'Enter 4-digit OTP'.customText(
                            style: isSmallScreen
                                ? CustomTextStyle.bodyMedium
                                : CustomTextStyle.bodyLarge,
                            color: AppColors.primaryDarkBlue,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: isSmallScreen ? 16 : 20),

                          // OTP Input Boxes - Now 4 boxes
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(4, (index) {
                              return SizedBox(
                                width: isSmallScreen ? 55 : 60,
                                height: isSmallScreen ? 55 : 60,
                                child: TextFormField(
                                  controller: _otpControllers[index],
                                  focusNode: _otpFocusNodes[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 20 : 22,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryDarkBlue,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    contentPadding: EdgeInsets.zero,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AppColors.primaryDarkBlue
                                            .withOpacity(0.3),
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: AppColors.primaryDarkBlue,
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (value) =>
                                      _onOtpChanged(value, index),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),

                      SizedBox(height: isSmallScreen ? 24 : 32),

                      // Verify OTP Button
                      CustomButton(
                        text: 'VERIFY OTP',
                        onPressed: _verifyOtp,
                        isLoading: authProvider.isLoading,
                        height: isSmallScreen ? 50 : 58,
                        variant: ButtonVariant.gradient,
                      ),

                      SizedBox(height: isSmallScreen ? 20 : 24),

                      // Resend OTP Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          'Didn\'t receive code?'.customText(
                            style: isSmallScreen
                                ? CustomTextStyle.bodySmall
                                : CustomTextStyle.bodyMedium,
                            color: const Color(0xFF5D4037),
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: _canResend ? _resendOtp : null,
                            child: _canResend
                                ? 'Resend OTP'.customText(
                                    style: isSmallScreen
                                        ? CustomTextStyle.bodySmall
                                        : CustomTextStyle.bodyMedium,
                                    color: AppColors.primaryDarkBlue,
                                    fontWeight: FontWeight.w700,
                                  )
                                : 'Resend in $_resendTimer s'.customText(
                                    style: isSmallScreen
                                        ? CustomTextStyle.bodySmall
                                        : CustomTextStyle.bodyMedium,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                          ),
                        ],
                      ),

                      // Demo OTP Hint
                      SizedBox(height: isSmallScreen ? 16 : 20),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.info.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.info.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              size: 16,
                              color: AppColors.info,
                            ),
                            SizedBox(width: 8),
                            'Demo OTP: 1234'.customText(
                              style: CustomTextStyle.bodySmall,
                              color: AppColors.info,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isSmallScreen ? 24 : 32),

                // Additional Info
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                  constraints: BoxConstraints(
                    maxWidth: isLargeScreen ? 500 : double.infinity,
                  ),
                  margin: isLargeScreen
                      ? EdgeInsets.symmetric(
                          horizontal: (screenWidth - 500) / 2)
                      : null,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: isSmallScreen ? 16 : 18,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 8),
                          'Enter the 4-digit code sent to your mobile'
                              .customText(
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

                SizedBox(height: isSmallScreen ? 20 : 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
