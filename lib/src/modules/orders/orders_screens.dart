import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_routes.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final status = (Get.arguments as Map<String, dynamic>? ?? {})['status'] ?? 'success';
    final isSuccess = status == 'success';
    return Scaffold(
      appBar: AppBar(title: Text(isSuccess ? 'Order placed' : 'Payment failed')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isSuccess ? Icons.check_circle : Icons.error, size: 96, color: isSuccess ? Colors.green : Colors.red),
            const SizedBox(height: 24),
            Text(
              isSuccess ? 'Your order is confirmed!' : 'Payment unsuccessful',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              isSuccess ? 'Track it inside orders tab.' : 'Please try another payment method.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () => Get.offAllNamed(AppRoutes.orders),
              child: const Text('View orders'),
            ),
            TextButton(
              onPressed: () => Get.offAllNamed(AppRoutes.home),
              child: const Text('Back to home'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {'id': 'ORD9821', 'domain': 'Restaurant', 'status': 'On the way', 'total': 720},
      {'id': 'ORD9820', 'domain': 'Grocery', 'status': 'Delivered', 'total': 420},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, index) {
          final order = orders[index];
          return ListTile(
            title: Text(order['id'] as String),
            subtitle: Text('${order['domain']} • ${order['status']}'),
            trailing: Text('₹${order['total']}'),
            onTap: () => Get.toNamed(AppRoutes.orderDetail, arguments: order),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: orders.length,
      ),
    );
  }
}

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments as Map<String, dynamic>? ?? {};
    return Scaffold(
      appBar: AppBar(title: Text(order['id'] ?? 'Order detail')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(order['status'] ?? 'Unknown'),
            subtitle: const Text('Placed on 21 Nov, 2025 • 7:18 PM'),
          ),
          const Divider(),
          const ListTile(
            title: Text('Items'),
            subtitle: Text('Paneer Tikka x1\nHydroponic Broccoli x2'),
          ),
          const Divider(),
          const ListTile(
            title: Text('Delivery details'),
            subtitle: Text('32 Palm Grove, Sector 62\nDriver assigned: Rajesh (XXXX45)'),
          ),
          const Divider(),
          const ListTile(
            title: Text('Payment'),
            subtitle: Text('Paid via Card • ₹720'),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => Get.toNamed(AppRoutes.home),
            child: const Text('Reorder'),
          ),
        ],
      ),
    );
  }
}

