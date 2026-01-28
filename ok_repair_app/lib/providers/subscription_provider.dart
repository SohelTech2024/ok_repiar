import 'package:flutter/material.dart';

class SubscriptionProvider with ChangeNotifier {
  String? _selectedPlan;
  bool _isLoading = false;
  List<Map<String, dynamic>> _subscriptionPlans = [];

  // Getters
  String? get selectedPlan => _selectedPlan;
  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get subscriptionPlans => _subscriptionPlans;

  // Initialize subscription plans
  void initializeSubscriptions() {
    _subscriptionPlans = [
      {
        'id': 'starter',
        'name': 'Starter',
        'price': 1,
        'duration': '1 month',
        'features': [
          'Unlimited repair jobs',
          'Customer database with history',
          'View repair job history',
          'Generate basic invoices',
          'Customer management',
        ],
        'isPopular': false,
      },
      {
        'id': 'standard',
        'name': 'Standard',
        'price': 999,
        'duration': '1 month',
        'features': [
          'Everything in Starter',
          'Staff login access',
          'Advanced customer analytics',
          'Generate detailed reports',
          'Unlimited storage',
          'Priority support',
        ],
        'isPopular': true,
      },
      {
        'id': 'premium',
        'name': 'Premium',
        'price': 1999,
        'duration': '1 month',
        'features': [
          'Everything in Standard',
          'Multi-branch management',
          'Advanced inventory tracking',
          'Custom branding',
          'API access',
          'Dedicated account manager',
        ],
        'isPopular': false,
      },
    ];
    notifyListeners();
  }

  // Select a plan
  void selectPlan(String planId) {
    _selectedPlan = planId;
    notifyListeners();
  }

  // Process subscription
  Future<bool> processSubscription() async {
    if (_selectedPlan == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call for subscription processing
      await Future.delayed(const Duration(seconds: 2));

      // Here you would integrate with your payment gateway
      // For now, we'll just simulate success
      final success = true; // Replace with actual payment processing

      _isLoading = false;
      notifyListeners();

      return success;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Get plan details by ID
  Map<String, dynamic>? getPlanById(String planId) {
    try {
      return _subscriptionPlans.firstWhere(
            (plan) => plan['id'] == planId,
      );
    } catch (e) {
      return null;
    }
  }

  // Get current selected plan details
  Map<String, dynamic>? get selectedPlanDetails {
    if (_selectedPlan == null) return null;
    return getPlanById(_selectedPlan!);
  }

  // Reset selection
  void resetSelection() {
    _selectedPlan = null;
    notifyListeners();
  }

  // Check if user has active subscription
  bool get hasActiveSubscription {
    // Implement your logic to check active subscription
    return false;
  }

  // Get active subscription details
  Map<String, dynamic>? get activeSubscription {
    // Implement your logic to get active subscription
    return null;
  }
}