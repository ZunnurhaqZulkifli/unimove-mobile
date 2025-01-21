import 'package:unimove/api/dashboard_api.dart';
import 'package:unimove/controllers/biometric_controller.dart';
import 'package:unimove/controllers/customer_booking_controller.dart';
import 'package:unimove/controllers/dashboard_controller.dart';
import 'package:unimove/controllers/destination_controller.dart';
import 'package:unimove/controllers/driver_booking_controller.dart';
import 'package:unimove/controllers/driver_order_controller.dart';
import 'package:unimove/controllers/customer_order_controller.dart';
import 'package:unimove/controllers/wallet_controller.dart';
import 'package:unimove/helpers/storage.dart';
import 'package:unimove/pages/authentications/login.dart';
import 'package:unimove/models/user.dart';
import 'package:unimove/api/user_api.dart';
import 'package:get/get.dart';
import 'package:unimove/pages/settings/maintainance_mode.dart';

class BaseAppController extends GetxController {
  RxString auth_token = ''.obs;
  RxString user_type = ''.obs;

  var user = Rxn<User>();

  DashboardController dashboardController = Get.put(DashboardController());

  DestinationController destinationController =
      Get.put(DestinationController());

  BiometricController biometricController = Get.put(BiometricController());

  DriverOrderController driverOrderController =
      Get.put(DriverOrderController());

  DriverBookingController driverBookingController =
      Get.put(DriverBookingController());

  final customerBookingController = Get.put(CustomerBookingController());

  WalletController walletController = Get.put(WalletController());

  CustomerOrderController customerOrderController =
      Get.put(CustomerOrderController());

  List<Booking> historyBookings = [];

  RxBool historyBookingsLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    getToken();
  }

  void loadProfile() async {
    // clearSettings(); // master reset

    if (auth_token.value == '') {
      clearSettings();
      Get.offAll(() => LoginPage());
    }

    if (auth_token.value != '') {
      // await driverOrderController.loadOrders();

      if (!await userApi.profile()) {
        // revalidate the token
        clearSettings();
        Get.offAll(() => LoginPage());
      } else {
        // this redirects user to the biometrics page
        await biometricController.setupAppBiometrics(
          user.value!,
          dashboardController,
          this,
        );

        await destinationController.loadDestinations();
        await dashboardApi.loadDashboardImages();

        if (user_type.value == 'student' || user_type.value == 'staff') {
          await customerOrderController.checkHasOrder();
          await customerBookingController.checkHasBooking();
        }

        if (user_type.value == 'driver') {
          await driverOrderController.loadUnverifiedOrders();
        }

        // await walletController.loadWallet();
      }
    }
  }

  Future<bool> checkStatus() async {
    print('loading current api status...');
    bool status = await userApi.checkApi();

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

  String biometric = '';

  void clearSettings() {
    print('clearing all settings...');
    user = Rxn<User>();
    auth_token.value = '';
    user_type.value = '';
    historyBookings = [];
    // storage.erase(); // clear all storage
    storage.write('token', '');
    dashboardController.clearSettings();
    destinationController.clearSettings();
    biometricController.clearSettings();
    driverOrderController.clearSettings();
    driverBookingController.clearSettings();
    customerOrderController.clearSettings();
    customerBookingController.clearSettings();
    // hasOrder.value = false;
    // waitingRide.value = false;
    // onRide.value = false;
  }
}

final baseAppController = BaseAppController();
