import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../../providers/theme_provider.dart';
import '../../widgets/custom_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<IntroPage> _introPages = [
    IntroPage(
      title: 'Manage Your Business',
      description: 'Easily track your inventory, sales, and customer data in one place.',
      icon: Icons.business_center,
    ),
    IntroPage(
      title: 'Real-time Analytics',
      description: 'Get insights into your business performance with detailed analytics.',
      icon: Icons.analytics,
    ),
    IntroPage(
      title: 'Boost Your Sales',
      description: 'Increase your revenue with smart recommendations and marketing tools.',
      icon: Icons.trending_up,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, RouteNames.login);
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),

            // Page View
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _introPages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return IntroPageWidget(introPage: _introPages[index]);
                },
              ),
            ),

            // Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicators(),
            ),

            const SizedBox(height: 32),

            // Navigation Buttons
// Navigation Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  // Previous Button
                  if (_currentPage > 0)
                    Expanded(
                      child: CustomButton(
                        text: 'Previous',
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        variant: ButtonVariant.outlined,
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: 12),

                  // Next/Get Started Button with Gradient
                  Expanded(
                    flex: _currentPage > 0 ? 1 : 2,
                    child: CustomButton(
                      text: _currentPage == _introPages.length - 1
                          ? 'Get Started'
                          : 'Next',
                      onPressed: () {
                        if (_currentPage == _introPages.length - 1) {
                          Navigator.pushReplacementNamed(context, RouteNames.login);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      variant: ButtonVariant.gradient,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < _introPages.length; i++) {
      indicators.add(
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
          ),
        ),
      );
    }
    return indicators;
  }
}

class IntroPage {
  final String title;
  final String description;
  final IconData icon;

  IntroPage({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class IntroPageWidget extends StatelessWidget {
  final IntroPage introPage;

  const IntroPageWidget({super.key, required this.introPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              introPage.icon,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 48),

          // Title
          Text(
            introPage.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            introPage.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}