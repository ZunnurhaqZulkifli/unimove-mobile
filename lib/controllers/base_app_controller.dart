import 'package:get/get.dart';
import 'package:unimove/api/api.dart';
import 'package:unimove/helpers/storage.dart';
import 'package:unimove/models/user.dart';
import 'package:unimove/pages/dashboard.dart';
import 'package:unimove/pages/login.dart';

class BaseAppController extends GetxController {
  RxString auth_token = ''.obs;
  late User? user;

  @override
  void onInit() async {
    super.onInit();
    getToken();
  }

  void setToken(String token) {
    storage.write('token', token);
  }

  void getToken() {
    print('get token...');

    auth_token.value = storage.read('token') ?? '';
  }

  void setUser(User user) {
    this.user = user;
  }

  void clearSettings() {
    print('clearing all settings...');
    storage.erase();
    this.user = null;
  }

  void getProfile() async {
    // clearSettings();
    bool passed = false;

    if (auth_token.value == '') {
      clearSettings();
      Get.offAll(() => LoginPage());
    } else {
      passed = await api.profile();

      if (!passed) {
        clearSettings();
        Get.offAll(() => LoginPage());
      } else {
        Get.offAll(() => Dashboard());
      }
    }
  }
}

final baseAppController = BaseAppController();
