import 'package:unimove/controllers/biometric_controller.dart';
import 'package:unimove/controllers/dashboard_controller.dart';
import 'package:unimove/helpers/storage.dart';
import 'package:unimove/pages/login.dart';
import 'package:unimove/models/user.dart';
import 'package:unimove/api/api.dart';
import 'package:get/get.dart';

class BaseAppController extends GetxController {
  RxString auth_token = ''.obs;
  RxString user_type = ''.obs;
  late User? user;
  DashboardController dashboardController = Get.put(DashboardController());
  BiometricController biometricController = Get.put(BiometricController());

  @override
  void onInit() async {
    super.onInit();
    getToken();
  }

  void setToken(String token) {
    storage.write('token', token);
  }

  void getToken() {
    auth_token.value = storage.read('token') ?? '';
    print('auth_token : $auth_token');
  }

  void setUser(User user) {
    this.user = user;
  }

  String biometric = '';

  void getProfile() async {
    // clearSettings(); // master reset

    print('hit dashbord controller');

    if (auth_token.value == '') {
      clearSettings();
      Get.offAll(() => LoginPage());
    }

    if (auth_token.value != '') {
      if (!await api.profile()) {
        // revalidate the token
        clearSettings();
        Get.offAll(() => LoginPage());
      } else {
        await biometricController.setupAppBiometrics(user!, dashboardController, this);
      }
    }
  }

  void clearSettings() {
    print('clearing all settings...');
    user = null;
    auth_token.value = '';
    user_type.value = '';
    storage.erase();
    dashboardController.clearSettings();
    biometricController.clearSettings();
  }
}

final baseAppController = BaseAppController();
