import 'package:flutter/material.dart';
import 'package:ok_repair_app/providers/home_provider.dart';
import 'package:ok_repair_app/ui/screens/auth/signup_screen.dart';
import 'package:ok_repair_app/ui/screens/jobcard/payment_screen.dart';
import 'package:ok_repair_app/ui/screens/subscription/subscription_purchase_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_filter_tabs.dart';
import '../../widgets/custom_job_card.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'all';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize jobs data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().initializeJobs();
    });
  }

  // FIXED: Proper screens list - don't include HomeScreen within itself
  List<Widget> get _screens => [
    _buildHomeContent(), // Current home content
    const SignupScreen(),
    const PaymentScreen(),
    const PurchaseSubscriptionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.professionalBackground,
      appBar: const HomeAppBar(
        notificationCount: 3,
        onNotificationPressed: _handleNotifications,
        onMenuPressed: _handleMenu,
      ),
      body: _screens[_currentIndex], // Use the screens list
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  // Extract home content as a separate widget
  Widget _buildHomeContent() {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        final filteredJobs = homeProvider.getFilteredJobs(_selectedFilter);
        final stats = homeProvider.getJobStats();

        return Column(
          children: [
            // Search Section
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  // Search Bar
                  CustomTextField(
                    controller: _searchController,
                    labelText: '',
                    hintText: 'Search by Anything',
                    prefixIcon: Icons.search_rounded,
                    onChanged: (value) {
                      homeProvider.searchJobs(value);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Filter Tabs
                  FilterTabs(
                    selectedFilter: _selectedFilter,
                    onFilterChanged: (filter) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    stats: stats,
                  ),
                ],
              ),
            ),

            // Jobs List
            Expanded(
              child: Container(
                color: AppColors.professionalBackground,
                child: filteredJobs.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredJobs.length,
                  itemBuilder: (context, index) {
                    final job = filteredJobs[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: JobCard(
                        job: job,
                        onView: () => _handleViewJob(job),
                        onInvoice: () => _handleGenerateInvoice(job),
                        onDelete: () => _handleDeleteJob(job, context),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void _handleNotifications() {
    // Handle notifications
    print('Notifications pressed');
  }

  static void _handleMenu() {
    // Handle menu
    print('Menu pressed');
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_outline_rounded,
            size: 80,
            color: AppColors.professionalSubtext.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          'No jobs found'.customText(
            style: CustomTextStyle.headlineSmall,
            color: AppColors.professionalSubtext,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 8),
          'Create your first repair job to get started'.customText(
            style: CustomTextStyle.bodyMedium,
            color: AppColors.professionalSubtext.withOpacity(0.7),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _handleViewJob(Map<String, dynamic> job) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: 'Job Details'.customText(
          style: CustomTextStyle.headlineSmall,
          color: AppColors.professionalText,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            'Job ID: ${job['id']}'.customText(
              style: CustomTextStyle.bodyMedium,
              color: AppColors.professionalText,
            ),
            'Issue: ${job['issue']}'.customText(
              style: CustomTextStyle.bodyMedium,
              color: AppColors.professionalText,
            ),
            'Status: ${job['status']}'.customText(
              style: CustomTextStyle.bodyMedium,
              color: AppColors.professionalText,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: 'Close'.customText(
              style: CustomTextStyle.bodyMedium,
              color: AppColors.primaryDarkBlue,
            ),
          ),
        ],
      ),
    );
  }

  void _handleGenerateInvoice(Map<String, dynamic> job) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: 'Generating invoice for ${job['id']}'.customText(
          style: CustomTextStyle.bodyMedium,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primaryDarkBlue,
      ),
    );
  }

  void _handleDeleteJob(Map<String, dynamic> job, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: 'Delete Job'.customText(
          style: CustomTextStyle.headlineSmall,
          color: AppColors.professionalText,
        ),
        content: 'Are you sure you want to delete ${job['id']}?'.customText(
          style: CustomTextStyle.bodyMedium,
          color: AppColors.professionalText,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: 'Cancel'.customText(
              style: CustomTextStyle.bodyMedium,
              color: AppColors.professionalSubtext,
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<HomeProvider>().deleteJob(job['id']);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: 'Job deleted successfully'.customText(
                    style: CustomTextStyle.bodyMedium,
                    color: Colors.white,
                  ),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: 'Delete'.customText(
              style: CustomTextStyle.bodyMedium,
              color: AppColors.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}