import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsService {
  SettingsService._();

  static final SettingsService instance = SettingsService._();
  final _box = GetStorage('fg_settings');

  Future<void> init() async {
    await GetStorage.init('fg_settings');
  }

  ThemeMode loadThemeMode() {
    final mode = _box.read<String>('themeMode');
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    await _box.write('themeMode', mode.name);
  }

  Locale loadLocale() {
    final code = _box.read<String>('locale') ?? 'en_US';
    final parts = code.split('_');
    return Locale(parts[0], parts.length > 1 ? parts[1] : '');
  }

  Future<void> saveLocale(Locale locale) async {
    final value = locale.countryCode?.isNotEmpty == true
        ? '${locale.languageCode}_${locale.countryCode}'
        : locale.languageCode;
    await _box.write('locale', value);
  }
}

class SettingsController extends GetxController {
  final SettingsService _service = SettingsService.instance;
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;
  final Rx<Locale> _locale = const Locale('en', 'US').obs;

  ThemeMode get themeMode => _themeMode.value;
  Locale get locale => _locale.value;

  @override
  void onInit() {
    super.onInit();
    _themeMode.value = _service.loadThemeMode();
    _locale.value = _service.loadLocale();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    _service.saveThemeMode(mode);
  }

  void switchLocale(Locale locale) {
    _locale.value = locale;
    _service.saveLocale(locale);
  }
}

