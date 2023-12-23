import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeServiceProvider =
    StateNotifierProvider<ThemeService, ThemeMode>((ref) => ThemeService());

class ThemeService extends StateNotifier<ThemeMode> {
  late final SharedPreferences _prefs;

  ThemeService() : super(ThemeMode.light) {
    _init();
  }

  // return true if theme mode is light
  bool get themeMode => state.index == 1;

  // initialize shared preference and get the theme mode
  void _init() async {
    _prefs = await SharedPreferences.getInstance();
    final themeMode = _prefs.getInt("THEME") ?? state.index;

    state = ThemeMode.values[themeMode];
  }

  // change theme
  void setTheme(ThemeMode themeMode) {
    state = themeMode;
    _prefs.setInt("THEME", state.index);
  }
}
