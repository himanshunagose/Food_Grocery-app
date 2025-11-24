import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/local_db_service.dart';
import 'config/app_bindings.dart';
import 'config/app_pages.dart';
import 'config/app_theme.dart';
import 'config/app_translations.dart';
import 'services/settings_service.dart';

class AppBootstrap {
  static Future<void> init() async {
    await GetStorage.init();
    await SettingsService.instance.init();
    await Hive.initFlutter();
    await LocalDbService.instance.init();
  }
}

class FoodGroceryApp extends StatelessWidget {
  const FoodGroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settings = Get.put(SettingsController(), permanent: true);
    return Obx(
      () => GetMaterialApp(
        title: 'Food & Grocery Delivery',
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.initial,
        getPages: AppPages.pages,
        initialBinding: AppBindings(),
        translations: AppTranslations(),
        locale: settings.locale,
        fallbackLocale: const Locale('en', 'US'),
        themeMode: settings.themeMode,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
      ),
    );
  }
}

