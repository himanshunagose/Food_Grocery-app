import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_routes.dart';

class AdminProductListScreen extends StatelessWidget {
  const AdminProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {'name': 'Alphonso Mango', 'domain': 'Grocery'},
      {'name': 'Paneer Tikka', 'domain': 'Restaurant'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Local catalog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Get.toNamed(AppRoutes.adminForm),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, index) {
          final product = products[index];
          return ListTile(
            title: Text(product['name'] as String),
            subtitle: Text(product['domain'] as String),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Get.toNamed(AppRoutes.adminForm, arguments: product),
            ),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: products.length,
      ),
    );
  }
}

class AdminProductFormScreen extends StatelessWidget {
  const AdminProductFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments as Map<String, dynamic>? ?? {};
    final TextEditingController nameCtrl = TextEditingController(text: product['name'] as String?);
    final TextEditingController descCtrl = TextEditingController(text: product['description'] as String?);

    return Scaffold(
      appBar: AppBar(title: Text(product.isEmpty ? 'Add product' : 'Edit product')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(value: 'restaurant', child: Text('Restaurant')),
                DropdownMenuItem(value: 'grocery', child: Text('Grocery')),
              ],
              onChanged: (_) {},
              decoration: const InputDecoration(labelText: 'Domain'),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () => Get.back(result: {
                'name': nameCtrl.text,
                'description': descCtrl.text,
              }),
              child: const Text('Save locally'),
            ),
          ],
        ),
      ),
    );
  }
}

