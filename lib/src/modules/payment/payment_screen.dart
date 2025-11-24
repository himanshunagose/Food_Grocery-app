import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_routes.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String method = 'card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mock payment')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose payment mode'),
            const SizedBox(height: 16),
            ...[
              _PaymentOption(label: 'Card', value: 'card', icon: Icons.credit_card),
              _PaymentOption(label: 'UPI', value: 'upi', icon: Icons.qr_code_rounded),
              _PaymentOption(label: 'Wallet', value: 'wallet', icon: Icons.account_balance_wallet_outlined),
              _PaymentOption(label: 'Cash on delivery', value: 'cod', icon: Icons.money),
            ].map(
              (option) => RadioListTile<String>(
                value: option.value,
                groupValue: method,
                onChanged: (value) => setState(() => method = value!),
                title: Text(option.label),
                secondary: Icon(option.icon),
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () => Get.offAllNamed(AppRoutes.orderConfirmation, arguments: {'status': 'success'}),
              child: const Text('Simulate success'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.orderConfirmation, arguments: {'status': 'failed'}),
              child: const Text('Simulate failure'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentOption {
  const _PaymentOption({required this.label, required this.value, required this.icon});

  final String label;
  final String value;
  final IconData icon;
}

