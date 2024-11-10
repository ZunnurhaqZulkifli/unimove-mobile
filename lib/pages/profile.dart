import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/api/api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/pages/settings.dart';
import 'package:unimove/themes/theme_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController passwordController = TextEditingController();
  final ThemeController themeController = Get.find();
  BaseAppController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Column(
          children: [
            Center(
              child: Text('Profile Page'),
            ),
            ListTile(
              title: Text('Application Settings'),
              onTap: () {
                Get.to(
                  () => SettingsPage(),
                );
              },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await api.logout();
                },
                child: Text(
                  'Logout',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      themeController.currentTheme.appBarTheme.backgroundColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
