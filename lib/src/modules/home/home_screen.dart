import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../config/app_routes.dart';
import '../../services/seed_loader.dart';

class HomeController extends GetxController {
  final SeedLoader loader = Get.find();

  final RxBool showGrocery = false.obs;
  final restaurants = <Map<String, dynamic>>[].obs;
  final categories = <Map<String, dynamic>>[].obs;
  final products = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSeeds();
  }

  Future<void> _loadSeeds() async {
    final restaurantSeed = await loader.loadJsonList('assets/seeds/restaurants.json');
    final groceryCategories = await loader.loadJsonList('assets/seeds/grocery_categories.json');
    final groceryProducts = await loader.loadJsonList('assets/seeds/products.json');

    restaurants.assignAll(
      restaurantSeed.map((e) => Map<String, dynamic>.from(e as Map)).toList(),
    );
    categories.assignAll(
      groceryCategories.map((e) => Map<String, dynamic>.from(e as Map)).toList(),
    );
    products.assignAll(
      groceryProducts.map((e) => Map<String, dynamic>.from(e as Map)).toList(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('app_title'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () => Get.toNamed(AppRoutes.search),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Get.toNamed(AppRoutes.cart),
          ),
        ],
      ),
      drawer: _HomeDrawer(),
      body: SafeArea(
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () async => controller.showGrocery.toggle(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _LocationChip(onChange: () {}),
                const SizedBox(height: 16),
                _DualToggle(
                  isGrocery: controller.showGrocery.value,
                  onToggle: controller.showGrocery,
                ),
                const SizedBox(height: 16),
                if (!controller.showGrocery.value) ...[
                  _FeaturedCarousel(restaurants: controller.restaurants),
                  const SizedBox(height: 24),
                  _SectionHeader(
                    label: 'Popular nearby',
                    actionLabel: 'See all',
                    onPressed: () {},
                  ),
                  ...controller.restaurants.map(
                    (data) => RestaurantCard(data: data),
                  ),
                ] else ...[
                  _SectionHeader(
                    label: 'Categories',
                    actionLabel: 'View all',
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => GroceryCategoryChip(
                        data: controller.categories[index],
                      ),
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemCount: controller.categories.length,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _SectionHeader(
                    label: 'Trending staples',
                    actionLabel: 'Repeat',
                    onPressed: () {},
                  ),
                  ...controller.products.map(
                    (product) => GroceryProductTile(data: product),
                  ),
                ],
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => Get.toNamed(AppRoutes.checkout),
                  icon: const Icon(Icons.flash_on_rounded),
                  label: const Text('Go to quick checkout'),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          switch (index) {
            case 1:
              Get.toNamed(AppRoutes.orders);
              break;
            case 2:
              Get.toNamed(AppRoutes.profile);
              break;
            case 3:
              Get.toNamed(AppRoutes.settings);
              break;
            default:
              break;
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.receipt_long), label: 'Orders'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }
}

class _HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            const ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Guest User'),
              subtitle: Text('guest@example.com'),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Order history'),
              onTap: () => Get.toNamed(AppRoutes.orders),
            ),
            ListTile(
              leading: const Icon(Icons.local_offer_outlined),
              title: const Text('Coupons'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.edit_note),
              title: const Text('Admin products'),
              onTap: () => Get.toNamed(AppRoutes.adminList),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.dark_mode_outlined),
              title: const Text('Theme & display'),
              onTap: () => Get.toNamed(AppRoutes.settings),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationChip extends StatelessWidget {
  const _LocationChip({required this.onChange});
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange,
      child: Chip(
        avatar: const Icon(Icons.location_pin, color: Colors.orange),
        label: const Text('Sector 62, Noida'),
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}

class _DualToggle extends StatelessWidget {
  const _DualToggle({required this.isGrocery, required this.onToggle});

  final bool isGrocery;
  final RxBool onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onToggle.value = false,
            child: _ToggleTile(
              icon: 'assets/icons/icon_restaurant.svg',
              title: 'home_restaurants'.tr,
              isActive: !isGrocery,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => onToggle.value = true,
            child: _ToggleTile(
              icon: 'assets/icons/icon_grocery.svg',
              title: 'home_grocery'.tr,
              isActive: isGrocery,
            ),
          ),
        ),
      ],
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.icon,
    required this.title,
    required this.isActive,
  });

  final String icon;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          SvgPicture.asset(icon, height: 56),
          const SizedBox(height: 12),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _FeaturedCarousel extends StatelessWidget {
  const _FeaturedCarousel({required this.restaurants});
  final List<Map<String, dynamic>> restaurants;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: PageController(viewportFraction: .9),
        itemCount: restaurants.length,
        itemBuilder: (_, index) {
          final data = restaurants[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SvgPicture.asset(
                data['image'] as String,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.label,
    required this.actionLabel,
    required this.onPressed,
  });

  final String label;
  final String actionLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleLarge),
        TextButton(onPressed: onPressed, child: Text(actionLabel)),
      ],
    );
  }
}

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.1),
          child: Text('${data['rating']}'),
        ),
        title: Text(data['name'] as String),
        subtitle: Text('${data['tags'].join(' • ')}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${data['etaMinutes']} mins'),
            Text('${data['distanceKm']} km', style: const TextStyle(fontSize: 12)),
          ],
        ),
        onTap: () => Get.toNamed(AppRoutes.restaurantDetail, arguments: data),
      ),
    );
  }
}

class GroceryCategoryChip extends StatelessWidget {
  const GroceryCategoryChip({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(int.parse(data['accent'].toString().replaceFirst('#', '0xff'))).withOpacity(.15),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(data['icon'] as String, height: 36),
          const Spacer(),
          Text(data['title'] as String, style: Theme.of(context).textTheme.titleSmall),
          Text(
            data['description'] as String,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class GroceryProductTile extends StatelessWidget {
  const GroceryProductTile({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SvgPicture.asset(
              data['image'] as String,
              height: 80,
              width: 80,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['name'] as String, style: Theme.of(context).textTheme.titleMedium),
                  Text(data['description'] as String),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: (data['unitOptions'] as List<dynamic>)
                        .map((option) => Chip(
                              label: Text(
                                '${option['label']} • ₹${option['price']}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => Get.toNamed(AppRoutes.cart),
              icon: const Icon(Icons.add_circle),
            ),
          ],
        ),
      ),
    );
  }
}

