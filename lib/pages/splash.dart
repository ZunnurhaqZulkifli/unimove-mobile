import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/themes/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  BaseAppController controller = Get.put(BaseAppController());
  final ThemeController themeController = Get.find();
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    controller.onInit();
    Timer(Duration(seconds: 4), () {
      setState(() {
        isVisible = true;
      });

      Future.delayed(Duration(milliseconds: 400), () async {
        bool status = await controller.checkStatus();

        if (!status) {
          return;
        } else {
          controller.loadProfile();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeController.currentTheme.scaffoldBackgroundColor,
      body: AnimatedOpacity(
        opacity: isVisible ? 0.0 : 1.0,
        duration: Duration(milliseconds: 450),
        curve: Curves.easeInOut,
        child: Center(
          child: Image(
            image: AssetImage(
              'assets/images/splash_background.png',
            ),
          ),
        ),
      ),
    );
  }
}
