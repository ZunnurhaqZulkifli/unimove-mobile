import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/pages/splash.dart';
import 'package:unimove/themes/theme_controller.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ThemeController());
  print('app themes initialized...');

  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ThemeController themeController = Get.find();
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unimove Application',
        theme: themeController.currentTheme,
        home: const SplashScreen(),
      );
    });
  }
}
