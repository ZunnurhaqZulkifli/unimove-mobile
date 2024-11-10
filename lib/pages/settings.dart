import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/themes/theme_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Obx(
              () => Column(
                children: [
                  SwitchListTile(
                    title: Text('Dark Theme'),
                    value: themeController.isDarkTheme.value,
                    onChanged: (bool value) {
                      setState(() {
                        themeController
                            .toggleTheme(); // Toggle theme on switch change
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text('Biometric Authentication'),
                    ),
                  ),
                  SwitchListTile(
                    title: Text('Face ID'),
                    value: themeController.isDarkTheme.value,
                    onChanged: (bool value) {
                      setState(() {
                        themeController
                            .toggleTheme(); // Toggle theme on switch change
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Fingerprint'),
                    value: themeController.isDarkTheme.value,
                    onChanged: (bool value) {
                      setState(() {
                        themeController
                            .toggleTheme(); // Toggle theme on switch change
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Passcode'),
                    value: themeController.isDarkTheme.value,
                    onChanged: (bool value) {
                      setState(() {
                        themeController
                            .toggleTheme(); // Toggle theme on switch change
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text('Location Services'),
                    ),
                  ),
                  SwitchListTile(
                    title: Text('Enable Location Services'),
                    value: themeController.isDarkTheme.value,
                    onChanged: (bool value) {
                      setState(() {
                        themeController
                            .toggleTheme(); // Toggle theme on switch change
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
