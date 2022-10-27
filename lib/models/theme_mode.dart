import 'package:flutter/material.dart';
import 'package:pokemon_pictorial_book/utils/theme_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeNotifier extends ChangeNotifier {
  ThemeModeNotifier(this.pref) {
    init();
  }
  late ThemeMode _themeMode;

  final SharedPreferences pref;

  ThemeMode get mode => _themeMode;

  void init() async {
    _themeMode = await loadThemeMode(pref);
    notifyListeners();
  }

  void update(ThemeMode newMode) {
    _themeMode = newMode;
    saveThemeMode(_themeMode);
    notifyListeners();
  }
}
