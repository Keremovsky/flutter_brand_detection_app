import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/services/stroage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeServiceProvider =
    StateNotifierProvider<ThemeService, ThemeMode>((ref) => ThemeService());

class ThemeService extends StateNotifier<ThemeMode> {
  final StorageService _storageService;

  ThemeService()
      : _storageService = StorageService(),
        super(ThemeMode.light) {
    final themeMode = _storageService.getData("THEME") as int? ?? state.index;
    state = ThemeMode.values[themeMode];
  }

  // return true if theme mode is light
  bool get themeMode => state.index == 1;

  // change theme
  void setTheme(ThemeMode themeMode) {
    state = themeMode;
    _storageService.setInt("THEME", state.index);
  }
}
