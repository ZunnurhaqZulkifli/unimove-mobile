import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/controllers/biometric_controller.dart';
import 'package:unimove/themes/theme_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ThemeController themeController = Get.find();
  final BiometricController biometricController = Get.find();
  bool? face_id;
  bool? fingerprint;
  bool? passcode;
  String? passcode_number;

  @override
  void initState() {
    super.initState();

    setState(() {
      face_id = biometricController.biometric.value.face_id!;
      fingerprint = biometricController.biometric.value.fingerprint!;
      passcode = biometricController.biometric.value.passcode!;
      passcode_number = biometricController.biometric.value.passcode_number!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings Page',
          style: themeController.currentTheme.textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Obx(
              () => Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text('Biometric Authentication',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.all(0),
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
                      padding: const EdgeInsets.only(top: 40, bottom: 10),
                      child: Text(
                        'Biometric Authentication',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text('Face ID'),
                    value: biometricController.biometric.value.face_id!,
                    onChanged: (bool value) {
                      setState(() {
                        if (value) {
                          print('value passcode');
                          biometricController.biometric.value.fingerprint =
                              false;
                          biometricController.biometric.value.face_id = value;
                          biometricController.updateBiometric({
                            'type': 'face_id',
                          });
                        } else {
                          biometricController.biometric.value.fingerprint =
                              false;
                          biometricController.biometric.value.face_id = value;
                          biometricController.updateBiometric({
                            'type': 'passcode',
                          });
                        }
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Fingerprint'),
                    contentPadding: EdgeInsets.all(0),
                    value: biometricController.biometric.value.fingerprint!,
                    onChanged: (bool value) {
                      setState(() {
                        if (value) {
                          biometricController.biometric.value.face_id = false;
                          biometricController.biometric.value.fingerprint =
                              value;
                          biometricController.updateBiometric({
                            'type': 'fingerprint',
                          });
                        } else {
                          biometricController.biometric.value.fingerprint =
                              value;
                          biometricController.biometric.value.face_id = true;
                          biometricController.updateBiometric({
                            'type': 'passcode',
                          });
                        }
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Passcode'),
                    contentPadding: EdgeInsets.all(0),
                    value: biometricController.biometric.value.passcode!,
                    onChanged: (bool value) {
                      setState(() {
                        biometricController.biometric.value.face_id = false;
                        biometricController.biometric.value.fingerprint = false;
                        biometricController.biometric.value.passcode = true;
                        biometricController.updateBiometric({
                          'type': 'passcode',
                        });
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
