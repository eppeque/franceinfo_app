import 'package:flutter/material.dart';
import 'package:franceinfo_app/src/settings/settings_service.dart';

class SettingsController with ChangeNotifier {
  final SettingsService _settingsService;

  SettingsController(this._settingsService);

  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;
    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
  }
}