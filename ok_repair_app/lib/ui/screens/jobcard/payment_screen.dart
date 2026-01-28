import 'package:flutter/material.dart';
import 'package:ok_repair_app/ui/widgets/custom_text.dart';

import '../../../core/constants/app_colors.dart';
import '../../widgets/custom_button.dart';


class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.professionalSurface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Summary Cards
            _buildSummarySection(),
            const SizedBox(height: 24),

            // Invoice List
            _buildInvoiceList(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Total Sale
          _buildSummaryRow(
            title: 'Total Sale',
            amount: '¥1600',
            color: AppColors.professionalText,
            icon: Icons.shopping_cart_rounded,
            iconText: 'Sales',
          ),
          const SizedBox(height: 16),

          // Total Amount
          _buildSummaryRow(
            title: 'Total Amount',
            amount: '¥200',
            color: AppColors.successGreen,
            icon: Icons.payments_rounded,
            iconText: 'Received',
          ),
          const SizedBox(height: 16),

          // Total Pending
          _buildSummaryRow(
            title: 'Total Pending',
            amount: '¥1400',
            color: AppColors.warningOrange,
            icon: Icons.pending_actions_rounded,
            iconText: 'Pending',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String title,
    required String amount,
    required Color color,
    required IconData icon,
    required String iconText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side - Icon with text
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 20,
                color: color,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                iconText.customText(
                  style: CustomTextStyle.bodySmall,
                  color: AppColors.professionalSubtext,
                ),
                const SizedBox(height: 2),
                title.customText(
                  style: CustomTextStyle.bodyMedium,
                  color: AppColors.professionalText,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ],
        ),

        // Right side - Amount
        amount.customText(
          style: CustomTextStyle.titleLarge,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget _buildInvoiceList() {
    return Column(
      children: [
        // Invoice 1
        _buildInvoiceCard(
          invoiceNumber: 'Inv-js002',
          partyName: 'ganesh services',
          totalAmount: '¥1000.00',
          receivedAmount: '¥0.00',
          dueAmount: '¥1000.00',
          onAddPayment: () {
            // Handle add payment for invoice 1
          },
        ),
        const SizedBox(height: 16),

        // Invoice 2
        _buildInvoiceCard(
          invoiceNumber: 'Inv-js003',
          partyName: 'new customerfff',
          totalAmount: '¥600',
          receivedAmount: '¥200',
          dueAmount: '¥400',
          onAddPayment: () {
            // Handle add payment for invoice 2
          },
        ),
      ],
    );
  }

  Widget _buildInvoiceCard({
    required String invoiceNumber,
    required String partyName,
    required String totalAmount,
    required String receivedAmount,
    required String dueAmount,
    required VoidCallback onAddPayment,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Invoice Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  invoiceNumber.customText(
                    style: CustomTextStyle.titleLarge,
                    color: AppColors.professionalText,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 4),
                  'Party - $partyName'.customText(
                    style: CustomTextStyle.bodyMedium,
                    color: AppColors.professionalSubtext,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Divider
          Container(
            height: 1,
            color: AppColors.professionalSurface,
          ),
          const SizedBox(height: 16),

          // Amount Details
          _buildAmountRow(
            label: 'Total',
            amount: totalAmount,
            isBold: true,
          ),
          const SizedBox(height: 8),
          _buildAmountRow(
            label: 'Received',
            amount: receivedAmount,
            isBold: true,
          ),
          const SizedBox(height: 8),
          _buildAmountRow(
            label: 'Due',
            amount: dueAmount,
            isBold: true,
            color: AppColors.warningOrange,
          ),
          Center(
            child: CustomButton(
              text: 'Add',
              onPressed: onAddPayment,
              variant: ButtonVariant.outlined,
              height: 36,
              expanded: false,
              borderRadius: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow({
    required String label,
    required String amount,
    bool isBold = false,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        label.customText(
          style: CustomTextStyle.bodyMedium,
          color: AppColors.professionalSubtext,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
        ),
        amount.customText(
          style: CustomTextStyle.bodyMedium,
          color: color ?? AppColors.professionalText,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
        ),
      ],
    );
  }
}

// If you need a separate payment dialog
class PaymentDialog extends StatelessWidget {
  final String invoiceNumber;
  final String partyName;
  final String dueAmount;

  const PaymentDialog({
    super.key,
    required this.invoiceNumber,
    required this.partyName,
    required this.dueAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Add Payment'.customText(
                  style: CustomTextStyle.headlineSmall,
                  color: AppColors.professionalText,
                  fontWeight: FontWeight.w600,
                ),
                CustomIconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icons.close,
                  backgroundColor: AppColors.professionalSurface,
                  iconColor: AppColors.professionalText,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Invoice Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.professionalSurface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  invoiceNumber.customText(
                    style: CustomTextStyle.bodyMedium,
                    color: AppColors.professionalText,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 4),
                  'Party: $partyName'.customText(
                    style: CustomTextStyle.bodySmall,
                    color: AppColors.professionalSubtext,
                  ),
                  const SizedBox(height: 4),
                  'Due: $dueAmount'.customText(
                    style: CustomTextStyle.bodySmall,
                    color: AppColors.warningOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Payment Amount Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Payment Amount'.customText(
                  style: CustomTextStyle.bodyMedium,
                  color: AppColors.professionalText,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 8),
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.professionalSubtext.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      '¥'.customText(
                        style: CustomTextStyle.bodyLarge,
                        color: AppColors.professionalText,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter amount',
                            hintStyle: TextStyle(
                              color: AppColors.professionalSubtext.withOpacity(0.6),
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.professionalText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Payment Method
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Payment Method'.customText(
                  style: CustomTextStyle.bodyMedium,
                  color: AppColors.professionalText,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 8),
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.professionalSubtext.withOpacity(0.3),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: 'Cash',
                      items: ['Cash', 'Bank Transfer', 'Credit Card', 'Digital Payment']
                          .map((method) => DropdownMenuItem(
                        value: method,
                        child: method.customText(
                          style: CustomTextStyle.bodyMedium,
                          color: AppColors.professionalText,
                        ),
                      ))
                          .toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    onPressed: () => Navigator.pop(context),
                    variant: ButtonVariant.outlined,
                    height: 48,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'Confirm Payment',
                    onPressed: () {
                      // Handle payment confirmation
                      Navigator.pop(context);
                    },
                    variant: ButtonVariant.primary,
                    height: 48,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}