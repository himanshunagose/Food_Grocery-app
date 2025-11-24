import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../config/app_routes.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedPack = 0;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments ?? {};
    final unitOptions = (data['unitOptions'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>();

    return Scaffold(
      appBar: AppBar(title: Text(data['name'] ?? 'Product')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SvgPicture.asset(data['image'] ?? 'assets/images/grocery/broccoli.svg', height: 160),
            const SizedBox(height: 24),
            Text(data['description'] ?? '', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Select pack', style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: List.generate(
                unitOptions.length,
                (index) => ChoiceChip(
                  label: Text('${unitOptions[index]['label']} • ₹${unitOptions[index]['price']}'),
                  selected: selectedPack == index,
                  onSelected: (_) => setState(() => selectedPack = index),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quantity', style: Theme.of(context).textTheme.titleMedium),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => setState(() => quantity = (quantity - 1).clamp(1, 99)),
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text('$quantity', style: Theme.of(context).textTheme.titleLarge),
                    IconButton(
                      onPressed: () => setState(() => quantity++),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.toNamed(AppRoutes.cart),
                    child: const Text('Go to cart'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Get.toNamed(AppRoutes.checkout),
                    child: const Text('Add & checkout'),
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

