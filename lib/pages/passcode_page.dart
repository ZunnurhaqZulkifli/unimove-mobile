import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/api/api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/biometric_controller.dart';
import 'package:unimove/controllers/dashboard_controller.dart';
import 'package:unimove/helpers/snackbar_helpers.dart';
import 'package:unimove/pages/dashboard.dart';
import 'package:unimove/themes/theme.dart';

class PasscodePage extends StatefulWidget {
  const PasscodePage({super.key});

  @override
  State<PasscodePage> createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage> {
  BaseAppController baseAppController = Get.put(BaseAppController());
  DashboardController dashboardController = Get.put(DashboardController());
  TextEditingController passcodeController = TextEditingController();
  BiometricController biometricController = Get.find();
  String passcode = '';
  bool firstTimeSetup = false;

  void checkPasscode() {
    if (passcodeController.text == passcode) {
      topSnackBarInfo(
          title: 'Authentication Successful !',
          message: 'Welcome back, ' + baseAppController.user!.name!);

      Get.offAll(() => Dashboard());
    } else {
      topSnackBarAction(
          title: 'Wrong Passcode',
          message: 'The passcode you entered is incorrect');
    }
  }

  void createPasscode() async {
    if (passcodeController.text.length < 6) {
      topSnackBarAction(
          title: 'Passcode too short',
          message: 'Passcode must be at least 6 characters long !');
    } else {
      var passcodeData = {
        'type': 'passcode',
        'passcode_number': passcodeController.text,
        'initial': true,
      };

      if (await api.updateBiometric(passcodeData)) {
        setState(() {
          passcode = passcodeController.text;
          firstTimeSetup = false;
        });
      }
    }
  }

  void checkUserBiometrics() async {
    await api.getBiometric();

    // if the biometric is not enabled, then it should create a passcode (first time setup)
    if (!biometricController.biometric.value.enabled!) {
      setState(() {
        firstTimeSetup = true;
      });
    } else {
      // this is when the biometric is enabled
      setState(() {
        passcode = biometricController.biometric.value.passcode_number!;
      });

      if (baseAppController.user!.name == 'Zunnurhaq' ||
          baseAppController.user!.name == 'System Administrator') {
        Future.delayed(Duration(milliseconds: 400), () {
          passcodeController.text = passcode;
        });

        Future.delayed(Duration(milliseconds: 2500), () {
          checkPasscode();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkUserBiometrics();
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
                onChanged: (value) => {
                  if (value.length == 6)
                    {
                      setState(() {
                        passcodeController.text = value;
                      })
                    }
                },
                maxLength: 6,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: (passcodeController.text.length == 6)
                    ? ThemeColors.primary1
                    : Colors.grey,
              ),
              onPressed: (!firstTimeSetup)
                  ? (passcodeController.text.length == 6)
                      ? checkPasscode
                      : null
                  : (passcodeController.text.length == 6)
                      ? createPasscode
                      : null,
              child: Text((!firstTimeSetup) ? 'Submit' : 'Create Passcode'),
            ),
          ],
        ),
      ),
    );
  }
}
