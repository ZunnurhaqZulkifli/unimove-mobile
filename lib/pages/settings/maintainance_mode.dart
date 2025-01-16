import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/themes/theme_controller.dart';

class MaintainanceMode extends StatefulWidget {
  const MaintainanceMode({super.key});

  @override
  State<MaintainanceMode> createState() => _MaintainanceModeState();
}

final ThemeController themeController = Get.find();

class _MaintainanceModeState extends State<MaintainanceMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maintainance Mode',
          style: themeController.currentTheme.textTheme.displayLarge,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'We are currently under maintainance',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Please try again later',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
