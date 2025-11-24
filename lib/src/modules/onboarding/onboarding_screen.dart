import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final pages = const [
    _OnboardPageData(
      title: 'Dual mode ordering',
      description: 'Switch between restaurant meals and grocery staples instantly.',
      asset: 'assets/images/banners/restaurant_spice.svg',
    ),
    _OnboardPageData(
      title: 'Local & offline ready',
      description: 'All data lives on-device with seed JSON & local storage.',
      asset: 'assets/images/grocery/alphonso.svg',
    ),
    _OnboardPageData(
      title: 'Track and manage',
      description: 'Cart, payments, orders, and admin controls in one place.',
      asset: 'assets/images/grocery/masala_combo.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.offAllNamed(AppRoutes.login),
                child: Text('skip'.tr),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (value) => setState(() => currentIndex = value),
                itemCount: pages.length,
                itemBuilder: (_, index) => _OnboardCard(data: pages[index]),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: currentIndex == index ? 32 : 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(
                          currentIndex == index ? 1 : .4,
                        ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FilledButton(
                onPressed: () {
                  if (currentIndex == pages.length - 1) {
                    Get.offAllNamed(AppRoutes.login);
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Text(currentIndex == pages.length - 1 ? 'get_started'.tr : 'next'.tr),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _OnboardCard extends StatelessWidget {
  const _OnboardCard({required this.data});
  final _OnboardPageData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SvgPicture.asset(
                    data.asset,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                data.title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                data.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardPageData {
  final String title;
  final String description;
  final String asset;

  const _OnboardPageData({
    required this.title,
    required this.description,
    required this.asset,
  });
}

