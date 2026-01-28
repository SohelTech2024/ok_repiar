import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _shopNameController = TextEditingController();
  final _gstController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _selectedShopType;
  String? _selectedPhoneCode = '+91';

  // Shop types
  final List<String> _shopTypes = [
    'Mobile Repair Center',
    'Authorized Service Center',
    'Mobile Accessories Shop',
    'Mobile Retail Store',
    'Multi-Brand Service Center',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF9C4),
              Color(0xFFFFF59D),
              Color(0xFFFFF176),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
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

                  const SizedBox(height: 20),

                  // Header Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Shop Registration'.customText(
                        style: CustomTextStyle.displaySmall,
                        color: Color(0xFF5D4037),
                        fontWeight: FontWeight.w800,
                      ),
                      const SizedBox(height: 8),
                      'Create your OK Repair business account'.customText(
                        style: CustomTextStyle.bodyMedium,
                        color: Color(0xFF5D4037),
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Registration Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 25,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Shop Type Dropdown
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Select Shop Type *'.customText(
                              style: CustomTextStyle.titleLarge,
                              color: Color(0xFF5D4037),
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 8),
                            CustomDropdown(
                              value: _selectedShopType,
                              items: _shopTypes,
                              hintText: 'Choose your shop type',
                              onChanged: (value) {
                                setState(() {
                                  _selectedShopType = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select shop type';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Shop Name
                        CustomTextField(
                          controller: _shopNameController,
                          labelText: 'Shop Name *',
                          hintText: 'Enter your shop name',
                          prefixIcon: Icons.store_rounded,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter shop name';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // GST Number (Optional)
                        CustomTextField(
                          controller: _gstController,
                          labelText: 'GST Number (Optional)',
                          hintText: 'Enter GST number if available',
                          prefixIcon: Icons.receipt_long_rounded,
                        ),

                        const SizedBox(height: 16),

                        // Owner Name
                        CustomTextField(
                          controller: _ownerNameController,
                          labelText: 'Owner Name *',
                          hintText: 'Enter owner full name',
                          prefixIcon: Icons.person_rounded,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter owner name';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Username for Community (Optional)
                        CustomTextField(
                          controller: _usernameController,
                          labelText: 'Username for Community (Optional)',
                          hintText: 'Choose a username',
                          prefixIcon: Icons.people_alt_rounded,
                        ),

                        const SizedBox(height: 20),

                        // Phone Number
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Phone Number *'.customText(
                              style: CustomTextStyle.titleLarge,
                              color: Color(0xFF5D4037),
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 8),
                            PhoneTextField(
                              controller: TextEditingController(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter phone number';
                                }
                                if (value.length < 10) {
                                  return 'Please enter valid 10-digit number';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Address
                        CustomTextField(
                          controller: _addressController,
                          labelText: 'Address *',
                          hintText: 'Enter complete shop address',
                          prefixIcon: Icons.location_on_rounded,
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter shop address';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Email
                        CustomTextField(
                          controller: _emailController,
                          labelText: 'Email ID *',
                          hintText: 'Enter your email address',
                          prefixIcon: Icons.email_rounded,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email address';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter valid email address';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Password
                        PasswordTextField(
                          controller: _passwordController,
                          labelText: 'Password *',
                          hintText: 'Create a secure password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        // Shop Logo Upload
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.professionalSurface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primaryDarkBlue.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.photo_camera_rounded,
                                    size: 20,
                                    color: AppColors.primaryDarkBlue,
                                  ),
                                  const SizedBox(width: 8),
                                  'Shop Logo (Optional)'.customText(
                                    style: CustomTextStyle.bodyMedium,
                                    color: Color(0xFF5D4037),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.professionalSubtext
                                        .withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    'Choose file'.customText(
                                      style: CustomTextStyle.bodyMedium,
                                      color: AppColors.professionalSubtext,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryDarkBlue,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: 'Browse'.customText(
                                        style: CustomTextStyle.bodySmall,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              'No file chosen'.customText(
                                style: CustomTextStyle.bodySmall,
                                color: AppColors.professionalSubtext,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Register Button
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    AppColors.primaryDarkBlue.withOpacity(0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: CustomButton(
                            text: 'REGISTER',
                            onPressed: _register,
                            isLoading: _isLoading,
                            height: 58,
                            variant: ButtonVariant.gradient,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Login Redirect
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Already have an account?'.customText(
                          style: CustomTextStyle.bodyMedium,
                          color: Color(0xFF5D4037),
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RouteNames.login);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: 'Login here'.customText(
                            style: CustomTextStyle.bodyMedium,
                            color: AppColors.primaryDarkBlue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Navigate to home screen
      Navigator.pushReplacementNamed(context, RouteNames.purchaseSubscription);
    }
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _gstController.dispose();
    _ownerNameController.dispose();
    _usernameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
