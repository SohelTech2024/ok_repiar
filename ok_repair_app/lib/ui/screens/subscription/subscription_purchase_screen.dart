import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../../providers/subscription_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_subscrption_card.dart';
import '../../widgets/custom_text.dart';

class PurchaseSubscriptionScreen extends StatefulWidget {
  const PurchaseSubscriptionScreen({super.key});

  @override
  State<PurchaseSubscriptionScreen> createState() => _PurchaseSubscriptionScreenState();
}

class _PurchaseSubscriptionScreenState extends State<PurchaseSubscriptionScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize subscription data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SubscriptionProvider>().initializeSubscriptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF9C4), // Light Yellow
              Color(0xFFFFF59D), // Medium Yellow
              Color(0xFFFFF176), // Bright Yellow
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Consumer<SubscriptionProvider>(
              builder: (context, subscriptionProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 18,
                          color: AppColors.primaryDarkBlue,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Header Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'Choose Your Plan'.customText(
                          style: CustomTextStyle.displaySmall,
                          color: Color(0xFF5D4037),
                          fontWeight: FontWeight.w800,
                        ),
                        const SizedBox(height: 8),
                        'Unlock premium features and boost your productivity'.customText(
                          style: CustomTextStyle.bodyMedium,
                          color: Color(0xFF5D4037),
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Subscription Plans
                    Column(
                      children: [
                        // Starter Plan
                        SubscriptionCard(
                          planName: 'Starter',
                          price: '₹1',
                          duration: '1 month',
                          features: const [
                            'Unlimited repair jobs',
                            'Customer database with history',
                            'View repair job history',
                            'Generate basic invoices',
                            'Customer management',
                          ],
                          isPopular: false,
                          isSelected: subscriptionProvider.selectedPlan == 'starter',
                          onSelect: () => subscriptionProvider.selectPlan('starter'),
                        ),

                        const SizedBox(height: 20),

                        // Standard Plan
                        SubscriptionCard(
                          planName: 'Standard',
                          price: '₹999',
                          duration: '1 month',
                          features: const [
                            'Everything in Starter',
                            'Staff login access',
                            'Advanced customer analytics',
                            'Generate detailed reports',
                            'Unlimited storage',
                            'Priority support',
                          ],
                          isPopular: true,
                          isSelected: subscriptionProvider.selectedPlan == 'standard',
                          onSelect: () => subscriptionProvider.selectPlan('standard'),
                        ),

                        const SizedBox(height: 20),

                        // Premium Plan
                        SubscriptionCard(
                          planName: 'Premium',
                          price: '₹1,999',
                          duration: '1 month',
                          features: const [
                            'Everything in Standard',
                            'Multi-branch management',
                            'Advanced inventory tracking',
                            'Custom branding',
                            'API access',
                            'Dedicated account manager',
                          ],
                          isPopular: false,
                          isSelected: subscriptionProvider.selectedPlan == 'premium',
                          onSelect: () => subscriptionProvider.selectPlan('premium'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Help Text
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
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
                      child: Column(
                        children: [
                          const Icon(
                            Icons.help_outline_rounded,
                            size: 32,
                            color: AppColors.primaryDarkBlue,
                          ),
                          const SizedBox(height: 12),
                          'Need help deciding?'.customText(
                            style: CustomTextStyle.bodyLarge,
                            color: Color(0xFF5D4037),
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          'You can upgrade or cancel anytime from your profile.'.customText(
                            style: CustomTextStyle.bodyMedium,
                            color: Color(0xFF5D4037).withOpacity(0.7),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Continue Button
                    if (subscriptionProvider.selectedPlan != null)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryDarkBlue.withOpacity(0.4),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: CustomButton(
                          text: 'CONTINUE WITH ${subscriptionProvider.selectedPlan!.toUpperCase()}',
                          onPressed: () => _handleSubscription(context),
                          isLoading: subscriptionProvider.isLoading,
                          height: 58,
                        ),
                      ),

                    const SizedBox(height: 16),

                    // Back to Login
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, RouteNames.login);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.arrow_back_rounded,
                              size: 16,
                              color: AppColors.primaryDarkBlue,
                            ),
                            const SizedBox(width: 8),
                            'Back to Login'.customText(
                              style: CustomTextStyle.bodyMedium,
                              color: AppColors.primaryDarkBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubscription(BuildContext context) async {
    final subscriptionProvider = context.read<SubscriptionProvider>();

    if (subscriptionProvider.selectedPlan != null) {
      final success = await subscriptionProvider.processSubscription();

      if (success && mounted) {
        // Navigate to payment screen or home screen
        Navigator.pushReplacementNamed(context, RouteNames.home);
      }
    }
  }
}