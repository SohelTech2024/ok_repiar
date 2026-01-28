import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'custom_text.dart';

class JobCard extends StatelessWidget {
  final Map<String, dynamic> job;
  final VoidCallback onView;
  final VoidCallback onInvoice;
  final VoidCallback onDelete;

  const JobCard({
    super.key,
    required this.job,
    required this.onView,
    required this.onInvoice,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Job ID and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                job['id'].toString().customText( // Convert to string
                  style: CustomTextStyle.titleLarge,
                  color: AppColors.primaryDarkBlue,
                  fontWeight: FontWeight.w700,
                ),
                _buildStatusChip(job['status'].toString()), // Convert to string
              ],
            ),

            const SizedBox(height: 12),

            // Issue
            job['issue'].toString().customText( // Convert to string
              style: CustomTextStyle.bodyLarge,
              color: AppColors.professionalText,
              fontWeight: FontWeight.w600,
            ),

            const SizedBox(height: 16),

            // Customer Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.professionalBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.professionalSubtext.withOpacity(0.1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person_rounded,
                        size: 16,
                        color: AppColors.primaryDarkBlue,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: job['customerName'].toString().customText( // Convert to string
                          style: CustomTextStyle.bodyMedium,
                          color: AppColors.professionalText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (job['customerType'] == 'new')
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.success.withOpacity(0.3),
                            ),
                          ),
                          child: 'New'.customText(
                            style: CustomTextStyle.bodySmall,
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_android_rounded,
                        size: 14,
                        color: AppColors.professionalSubtext,
                      ),
                      const SizedBox(width: 8),
                      job['device'].toString().customText( // Convert to string
                        style: CustomTextStyle.bodyMedium,
                        color: AppColors.professionalSubtext,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_rounded,
                        size: 14,
                        color: AppColors.professionalSubtext,
                      ),
                      const SizedBox(width: 8),
                      job['phone'].toString().customText( // Convert to string
                        style: CustomTextStyle.bodyMedium,
                        color: AppColors.professionalSubtext,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Date and Actions
            Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 14,
                      color: AppColors.professionalSubtext,
                    ),
                    const SizedBox(width: 6),
                    'Added: ${job['addedDate']}'.customText( // This is already a string
                      style: CustomTextStyle.bodySmall,
                      color: AppColors.professionalSubtext,
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                _buildActionButtons(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    String statusText;

    switch (status) {
      case 'pending':
        backgroundColor = AppColors.warning.withOpacity(0.1);
        textColor = AppColors.warning;
        statusText = 'Pending';
        break;
      case 'repaired':
        backgroundColor = AppColors.info.withOpacity(0.1);
        textColor = AppColors.info;
        statusText = 'Repaired';
        break;
      case 'delivered':
        backgroundColor = AppColors.success.withOpacity(0.1);
        textColor = AppColors.success;
        statusText = 'Delivered';
        break;
      default:
        backgroundColor = AppColors.professionalSubtext.withOpacity(0.1);
        textColor = AppColors.professionalSubtext;
        statusText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: textColor.withOpacity(0.3),
        ),
      ),
      child: statusText.customText(
        style: CustomTextStyle.bodySmall,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // View Button
        _buildActionButton(
          'View',
          Icons.visibility_rounded,
          AppColors.primaryDarkBlue,
          onView,
        ),
        const SizedBox(width: 8),

        // Invoice Button
        _buildActionButton(
          'Invoice',
          Icons.receipt_long_rounded,
          AppColors.success,
          onInvoice,
        ),
        const SizedBox(width: 8),

        // Delete Button
        _buildActionButton(
          'Delete',
          Icons.delete_outline_rounded,
          AppColors.error,
          onDelete,
        ),
      ],
    );
  }

  Widget _buildActionButton(String text, IconData icon, Color color, VoidCallback onPressed) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: color.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: color,
              ),
              const SizedBox(width: 4),
              text.customText(
                style: CustomTextStyle.bodySmall,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}