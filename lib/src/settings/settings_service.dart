import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _themeCodeKey = 'themeCode';

  Future<ThemeMode> themeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeCode = prefs.getInt(_themeCodeKey) ?? 0;

    if (themeCode == 0) return ThemeMode.system;

    if (themeCode == 1) return ThemeMode.light;

    return ThemeMode.dark;
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    late int themeCode;

    switch (themeMode) {
      case ThemeMode.system:
        themeCode = 0;
        break;
      case ThemeMode.light:
        themeCode = 1;
        break;
      case ThemeMode.dark:
        themeCode = 2;
        break;
    }

    await prefs.setInt(_themeCodeKey, themeCode);
  }
}