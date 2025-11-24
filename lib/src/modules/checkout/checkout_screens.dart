import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_routes.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'Delivery address',
            actionLabel: 'Change',
            child: const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('32 Palm Grove, Sector 62'),
              subtitle: Text('Home • +91 98765 43210'),
            ),
          ),
          _SectionCard(
            title: 'Delivery slot',
            actionLabel: 'Edit',
            child: Wrap(
              spacing: 12,
              children: const [
                Chip(label: Text('Today • 7-8 PM')),
                Chip(label: Text('Schedule')),
              ],
            ),
          ),
          _SectionCard(
            title: 'Payment method',
            actionLabel: 'Change',
            child: Column(
              children: [
                RadioListTile(
                  value: 'card',
                  groupValue: 'card',
                  onChanged: (_) {},
                  title: const Text('Card • **** 4210'),
                ),
                RadioListTile(
                  value: 'upi',
                  groupValue: 'card',
                  onChanged: (_) {},
                  title: const Text('UPI • demo@upi'),
                ),
                RadioListTile(
                  value: 'cod',
                  groupValue: 'card',
                  onChanged: (_) {},
                  title: const Text('Cash on delivery'),
                ),
              ],
            ),
          ),
          _SectionCard(
            title: 'Order summary',
            child: Column(
              children: const [
                _SummaryRow(label: 'Items total', value: '₹480'),
                _SummaryRow(label: 'Delivery fee', value: '₹20'),
                _SummaryRow(label: 'Promo applied', value: '-₹80'),
                Divider(),
                _SummaryRow(label: 'Total payable', value: '₹420', isStrong: true),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => Get.toNamed(AppRoutes.payment),
            child: const Text('Place order'),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    this.actionLabel,
    this.child,
  });

  final String title;
  final String? actionLabel;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                if (actionLabel != null)
                  TextButton(onPressed: () {}, child: Text(actionLabel!)),
              ],
            ),
            if (child != null) ...[
              const SizedBox(height: 8),
              child!,
            ],
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.isStrong = false});

  final String label;
  final String value;
  final bool isStrong;

  @override
  Widget build(BuildContext context) {
    final style = isStrong ? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.bodyLarge;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}

