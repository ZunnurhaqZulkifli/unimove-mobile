import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/types/auth_messages_ios.dart';
import 'package:unimove/api/api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/dashboard_controller.dart';
import 'package:unimove/helpers/dialog_helpers.dart';
import 'package:unimove/helpers/snackbar_helpers.dart';
import 'package:unimove/models/user.dart';
import 'package:unimove/pages/passcode_page.dart';
import 'package:unimove/pages/dashboard.dart';

class Biometric {
  String? id;
  bool? face_id;
  bool? fingerprint;
  bool? passcode;
  String? passcode_number;
  bool? enabled = false;

  Biometric({
    required this.id,
    required this.face_id,
    required this.fingerprint,
    required this.passcode,
    required this.passcode_number,
    required this.enabled,
  });

  Biometric.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    face_id = (json['face_id'] == 1) ? true : false;
    fingerprint = (json['fingerprint'] == 1) ? true : false;
    passcode = (json['passcode'] == 1) ? true : false;
    passcode_number = json['passcode_number'].toString();
    enabled = (json['enabled'] == 1) ? true : false;
  }
}

class BiometricController extends GetxController {
  // Future biometric() async => await api.getBiometric();
  Rx<Biometric> biometric = Biometric(
    id: '-1',
    face_id: false,
    fingerprint: false,
    passcode: true,
    passcode_number: '',
    enabled: false,
  ).obs;

  List<String> app_biometric = [];
  RxInt auth_attempts = 1.obs;

  final LocalAuthentication auth = LocalAuthentication();
  // List<BiometricType>? _availableBiometrics;

  Future<bool> authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Authenticate to access UniMove',
        options: AuthenticationOptions(
          stickyAuth: false,
          sensitiveTransaction: true,
          biometricOnly: false,
        ),
        authMessages: [
          IOSAuthMessages(
            cancelButton: 'Cancel',
            goToSettingsButton: 'Settings',
            goToSettingsDescription: 'Please set up your Face Id / Touch Id.',
          ),
          AndroidAuthMessages(
            cancelButton: 'Cancel',
            goToSettingsButton: 'Settings',
            goToSettingsDescription: 'Please set up your Fingerprint.',
          ),
        ],
      );
    } on PlatformException catch (e) {
      print(e.code);
    } catch (e) {
      topSnackBarError(
          title: 'Error', message: 'An unexpected error occurred: $e');
    }

    return authenticated;
  }

  Future setupAppBiometrics(User user, DashboardController dashboardController,
      BaseAppController controller) async {
    biometric.value = await api.getBiometric(); // get the user's biometric

    Future.delayed(Duration(milliseconds: 600), () async {
      if (user.type == '') {
        print('profile is null');

        // this is the update popup
        UpdateProfilePopup();
        dashboardController.initialize(controller: controller);
      } else {
        if (biometric.value.enabled!) {
          // face_id only
          if (biometric.value.face_id == true) {
            bool authed = await authenticate();

            if (authed) {
              dashboardController.initialize(controller: controller);
              Get.offAll(() => Dashboard());
            } else {
              if (auth_attempts.value < 3) {
                auth_attempts.value++;

                print('passcode auth attempts : ${auth_attempts.value}');
                setupAppBiometrics(user, dashboardController, controller);
              } else {
                authenticatePasscode();
                dashboardController.initialize(controller: controller);
              }
            }
          }

          // fingerprint only
          if (biometric.value.fingerprint == true) {
            bool authed = await authenticate();

            if (authed) {
              dashboardController.initialize(controller: controller);
              Get.offAll(() => Dashboard());
            } else {
              if (auth_attempts.value < 3) {
                auth_attempts.value++;

                print('fingerprint auth attempts : ${auth_attempts.value}');
                setupAppBiometrics(user, dashboardController, controller);
              } else {
                authenticatePasscode();
              }
            }
          }

          if (biometric.value.passcode == true && biometric.value.fingerprint == false && biometric.value.face_id == false) {
            authenticatePasscode();
            dashboardController.initialize(controller: controller);
          }
        } else {
          print('this user is using the passcode');
          
          authenticatePasscode();
          dashboardController.initialize(controller: controller);
        }
      }
    });
  }

  void clearSettings() {
    app_biometric.clear();

    biometric.value = Biometric(
      id: '-1',
      face_id: false,
      fingerprint: false,
      passcode: true,
      passcode_number: '',
      enabled: false,
    );
  }

  void authenticatePasscode() {
    print('passcode');
    Get.offAll(() => PasscodePage());
  }
}
