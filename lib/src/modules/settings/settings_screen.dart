import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/settings_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Get.find<SettingsController>();
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: ListView(
        children: [
          Obx(
            () => SwitchListTile(
              title: Text('dark_mode'.tr),
              subtitle: const Text('Use dark appearance everywhere'),
              value: settings.themeMode == ThemeMode.dark,
              onChanged: (value) => settings.setThemeMode(value ? ThemeMode.dark : ThemeMode.light),
            ),
          ),
          ListTile(
            title: Text('language'.tr),
            subtitle: Text(settings.locale.languageCode == 'en' ? 'English' : 'हिन्दी'),
            trailing: const Icon(Icons.translate),
            onTap: () => settings.switchLocale(
              settings.locale.languageCode == 'en' ? const Locale('hi', 'IN') : const Locale('en', 'US'),
            ),
          ),
          const ListTile(
            title: Text('App info'),
            subtitle: Text('Version 1.0.0 • Offline-first demo'),
          ),
          const ListTile(
            title: Text('Clear cache'),
            subtitle: Text('Removes cart, orders & settings'),
          ),
        ],
      ),
    );
  }
}

