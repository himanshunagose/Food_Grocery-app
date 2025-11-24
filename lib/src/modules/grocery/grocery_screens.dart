import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../config/app_routes.dart';
import '../../services/seed_loader.dart';

class GroceryListingController extends GetxController {
  final SeedLoader loader = Get.find();
  final categories = <Map<String, dynamic>>[].obs;
  final products = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSeeds();
  }

  Future<void> _loadSeeds() async {
    final catSeed = await loader.loadJsonList('assets/seeds/grocery_categories.json');
    final prodSeed = await loader.loadJsonList('assets/seeds/products.json');
    categories.assignAll(catSeed.map((e) => Map<String, dynamic>.from(e as Map)).toList());
    products.assignAll(prodSeed.map((e) => Map<String, dynamic>.from(e as Map)).toList());
  }
}

class GroceryListingScreen extends StatelessWidget {
  const GroceryListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GroceryListingController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search greens, dairy, staples',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => _CategoryCard(data: controller.categories[index]),
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: controller.categories.length,
              ),
            ),
            const SizedBox(height: 24),
            ...controller.products.map(
              (item) => GroceryProductCard(data: item),
            ),
          ],
        ),
      ),
    );
  }
}

class GroceryProductCard extends StatelessWidget {
  const GroceryProductCard({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(data['image'] as String, height: 72),
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
                            .map((option) => ChoiceChip(
                                  label: Text('${option['label']} • ₹${option['price']}'),
                                  selected: false,
                                  onSelected: (_) {},
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.repeat),
                  label: const Text('Repeat'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Get.toNamed(AppRoutes.productDetail, arguments: data),
                    child: const Text('View & add'),
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

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(data['icon'] as String, height: 40),
          const Spacer(),
          Text(data['title'] as String, style: Theme.of(context).textTheme.titleSmall),
          Text(data['description'] as String, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

