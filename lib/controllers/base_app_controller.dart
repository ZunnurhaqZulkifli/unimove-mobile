import 'package:unimove/controllers/biometric_controller.dart';
import 'package:unimove/controllers/dashboard_controller.dart';
import 'package:unimove/controllers/destination_controller.dart';
import 'package:unimove/controllers/order_controller.dart';
import 'package:unimove/controllers/wallet_controller.dart';
import 'package:unimove/helpers/storage.dart';
import 'package:unimove/pages/login.dart';
import 'package:unimove/models/user.dart';
import 'package:unimove/api/api.dart';
import 'package:get/get.dart';
import 'package:unimove/pages/maintainance_mode.dart';

class BaseAppController extends GetxController {
  RxString auth_token = ''.obs;
  RxString user_type = ''.obs;
  late User? user;
  DashboardController dashboardController = Get.put(DashboardController());
  DestinationController destinationController =
      Get.put(DestinationController());
  BiometricController biometricController = Get.put(BiometricController());
  OrderController orderController = Get.put(OrderController());
  WalletController walletController = Get.put(WalletController());

  RxBool hasOrder = false.obs;
  RxBool waitingRide = false.obs;
  RxBool onRide = false.obs;

  @override
  void onInit() {
    super.onInit();
    getToken();
  }

  Future<bool> checkStatus() async {
    print('loading current api status...');
    bool status = await api.checkApi();

    if (!status) {
      clearSettings();
      Get.offAll(() => MaintainanceMode());
    }

    return status;
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

    // reference data loaded from the api
    await destinationController.loadDestinations();
    await orderController.loadOrders();

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
        // this redirects user to the biometrics page
        await biometricController.setupAppBiometrics(
            user!, dashboardController, this);
      }
    }
  }

  void clearSettings() {
    print('clearing all settings...');
    user = null;
    auth_token.value = '';
    user_type.value = '';
    // storage.erase(); // clear all storage
    storage.write('token', '');
    dashboardController.clearSettings();
    destinationController.clearSettings();
    biometricController.clearSettings();
    orderController.clearSettings();
    hasOrder.value = false;
    waitingRide.value = false;
    onRide.value = false;
  }
}

final baseAppController = BaseAppController();
