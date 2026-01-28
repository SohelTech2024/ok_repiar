import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'custom_text.dart';

class SubscriptionCard extends StatelessWidget {
  final String planName;
  final String price;
  final String duration;
  final List<String> features;
  final bool isPopular;
  final bool isSelected;
  final VoidCallback onSelect;

  const SubscriptionCard({
    super.key,
    required this.planName,
    required this.price,
    required this.duration,
    required this.features,
    this.isPopular = false,
    this.isSelected = false,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isSelected ? 0.2 : 0.1),
            blurRadius: isSelected ? 25 : 15,
            offset: const Offset(0, 6),
          ),
        ],
        border: isSelected
            ? Border.all(
          color: AppColors.primaryDarkBlue,
          width: 2,
        )
            : null,
      ),
      child: Stack(
        children: [
          // Popular Badge
          if (isPopular)
            Positioned(
              top: 5,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFC400)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: 'MOST POPULAR'.customText(
                  style: CustomTextStyle.bodySmall,
                  color: Color(0xFF5D4037),
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Plan Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        planName.customText(
                          style: CustomTextStyle.headlineMedium,
                          color: Color(0xFF5D4037),
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(height: 4),
                        '$price / $duration'.customText(
                          style: CustomTextStyle.bodyLarge,
                          color: AppColors.primaryDarkBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    // Selection Indicator
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryDarkBlue
                              : AppColors.professionalSubtext.withOpacity(0.3),
                          width: 2,
                        ),
                        color: isSelected ? AppColors.primaryDarkBlue : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Features List
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: features.map((feature) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 18,
                            color: AppColors.primaryDarkBlue,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: feature.customText(
                              style: CustomTextStyle.bodyMedium,
                              color: Color(0xFF5D4037),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // Select Button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: isSelected
                        ? const LinearGradient(
                      colors: [AppColors.primaryDarkBlue, AppColors.secondaryDarkBlue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                        : const LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : AppColors.primaryDarkBlue.withOpacity(0.3),
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: AppColors.primaryDarkBlue.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                        : null,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onSelect,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Center(
                          child: isSelected
                              ? 'SELECTED'.customText(
                            style: CustomTextStyle.bodyLarge,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )
                              : 'SELECT PLAN'.customText(
                            style: CustomTextStyle.bodyLarge,
                            color: AppColors.primaryDarkBlue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}