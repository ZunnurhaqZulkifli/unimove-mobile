import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unimove/themes/theme_controller.dart';

void main() async {
  await GetStorage.init();
  print('storage initialized...');

  Get.put(ThemeController());
  print('app themes initialized...');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ThemeController themeController = Get.find();

      return GetMaterialApp(
        title: 'Unimove Application',
        theme: themeController.currentTheme,
        home: const SplashScreen(title: 'Welcome to Unimove'),
      );
    });
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});
  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print('loading application');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeController.currentTheme.appBarTheme.backgroundColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const SettingsPage());
              },
              child: Text(
                'Settings Page',
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
        title: Text('Settings with GetX'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Choose Theme',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Obx(() => SwitchListTile(
                  title: Text('Dark Theme'),
                  value: themeController.isDarkTheme.value,
                  onChanged: (bool value) {
                    themeController
                        .toggleTheme(); // Toggle theme on switch change
                  },
                )),
          ],
        ),
      ),
    );
  }
}
