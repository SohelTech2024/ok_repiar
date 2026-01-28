import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final String? helperText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function()? onSuffixIconPressed;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool autoFocus;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final String? errorText;

  const CustomTextField({
    super.key,
    this.controller,
    required this.labelText,
    this.hintText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onSuffixIconPressed,
    this.onChanged,
    this.onSubmitted,
    this.autoFocus = false,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (labelText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              labelText,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.professionalText,
              ),
            ),
          ),

        // Text Field
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          autofocus: autoFocus,
          textInputAction: textInputAction,
          maxLines: maxLines,
          minLines: minLines,
          enabled: enabled,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.professionalText,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            helperText: helperText,
            prefixIcon: prefixIcon != null
                ? Padding(
              padding: const EdgeInsets.only(left: 16, right: 12),
              child: Icon(
                prefixIcon,
                size: 20,
                color: AppColors.professionalSubtext.withOpacity(0.6),
              ),
            )
                : null,
            suffixIcon: suffixIcon != null
                ? Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                icon: Icon(
                  suffixIcon,
                  size: 20,
                  color: AppColors.professionalSubtext.withOpacity(0.6),
                ),
                onPressed: onSuffixIconPressed,
              ),
            )
                : null,
            filled: true,
            fillColor: enabled ? AppColors.professionalSurface : AppColors.professionalSurface.withOpacity(0.6),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
          ),
        ),
      ],
    );
  }
}

// Specialized Text Fields
class PhoneTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const PhoneTextField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: 'Phone Number',
      hintText: 'Enter your 10-digit mobile number',
      prefixIcon: Icons.phone_iphone_rounded,
      keyboardType: TextInputType.phone,
      validator: validator,
      onChanged: onChanged,
      helperText: 'We\'ll send you a verification code',
      textInputAction: TextInputAction.next,
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? labelText;
  final String? hintText;

  const PasswordTextField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.labelText = 'Password',
    this.hintText = 'Enter your secure password',
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      labelText: widget.labelText!,
      hintText: widget.hintText!,
      prefixIcon: Icons.lock_rounded,
      suffixIcon: _obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded,
      obscureText: _obscureText,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSuffixIconPressed: _toggleVisibility,
      helperText: 'Must be at least 6 characters long',
      textInputAction: TextInputAction.done,
    );
  }
}