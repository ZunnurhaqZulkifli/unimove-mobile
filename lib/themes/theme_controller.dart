// lib/theme_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/helpers/storage.dart';
import 'theme.dart';

class ThemeController extends GetxController {
  static const String themeKey = "isDarkTheme";
  var isDarkTheme = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  ThemeData get currentTheme =>
      isDarkTheme.value ? AppThemes.darkTheme : AppThemes.lightTheme;

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    _saveTheme(isDarkTheme.value);
    Get.changeTheme(currentTheme);
  }

  void _saveTheme(bool isDark) async {
    await storage.write(themeKey, isDark);
  }

  void _loadTheme() async {
    isDarkTheme.value = storage.read(themeKey) ?? false;
    Get.changeTheme(currentTheme);
  }
}
