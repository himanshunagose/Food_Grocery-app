import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_routes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleCart = [
      {'title': 'Paneer Tikka', 'price': 260, 'qty': 1},
      {'title': 'Hydroponic Broccoli', 'price': 110, 'qty': 2},
    ];

    final total = sampleCart.fold<double>(
      0,
      (sum, item) => sum + (item['price'] as num) * (item['qty'] as num),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Your cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, index) {
                final item = sampleCart[index];
                return ListTile(
                  title: Text(item['title'] as String),
                  subtitle: const Text('Customisations • notes'),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('₹${item['price']}'),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: () {}, icon: const Icon(Icons.remove_circle_outline)),
                          Text('${item['qty']}'),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline)),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: sampleCart.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal'),
                    Text('₹${total.toStringAsFixed(0)}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Delivery slot'),
                    Text('Today • 7:00 PM'),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Get.toNamed(AppRoutes.checkout),
                    child: const Text('Proceed to checkout'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

