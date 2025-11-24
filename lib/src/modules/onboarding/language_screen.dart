import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_routes.dart';
import '../../services/settings_service.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Get.find<SettingsController>();
    final locales = const [
      Locale('en', 'US'),
      Locale('hi', 'IN'),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('language'.tr)),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemBuilder: (context, index) {
          final locale = locales[index];
          final isSelected = settings.locale.languageCode == locale.languageCode;
          return ListTile(
            tileColor: isSelected ? Theme.of(context).colorScheme.secondaryContainer : null,
            title: Text(
              locale.languageCode == 'en' ? 'English' : 'हिन्दी',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: _buildSelectionIcon(isSelected),
            onTap: () {
              settings.switchLocale(locale);
              Get.offAllNamed(AppRoutes.onboarding);
            },
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: locales.length,
      ),
    );
  }

  Widget? _buildSelectionIcon(bool selected) {
    if (!selected) return null;
    return const Icon(Icons.check_circle_rounded, color: Colors.green);
  }
}

