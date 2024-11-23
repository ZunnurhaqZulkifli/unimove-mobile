import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/dashboard_controller.dart';
import 'package:unimove/helpers/snackbar_helpers.dart';
import 'package:unimove/pages/dashboard.dart';

class PasscodePage extends StatefulWidget {
  const PasscodePage({super.key});

  @override
  State<PasscodePage> createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage> {
  BaseAppController baseAppController = Get.put(BaseAppController());
  DashboardController dashboardController = Get.put(DashboardController());
  TextEditingController passcodeController = TextEditingController();
  String passcode = '9909';

  void checkPasscode() {
    if (passcodeController.text == passcode) {
      Get.to(() => Dashboard());
    } else {
      topSnackBarAction(title: 'Wrong Passcode', message: 'The passcode you entered is incorrect');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Passcode'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: passcodeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Passcode',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: checkPasscode,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
