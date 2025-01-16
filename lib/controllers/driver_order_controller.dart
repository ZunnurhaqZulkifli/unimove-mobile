import 'package:get/get.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/models/order.dart';

class DriverOrderController extends GetxController {
  RxList<Order> pendingOrders = <Order>[].obs;
  RxBool loadedPendingOrders = false.obs;
  RxBool hasOrder = false.obs;
  bool isLoaded = false;
  // Rx<Booking>? booking;

  Future loadUnverifiedOrders() async {
    await driverApi.checkHasOrder();
    await driverApi.getOrderList();
  }

  Future acceptOrder(Order? order) async {
    await driverApi.acceptOrder(order!.id!);
  }

  Future getBooking() async {
    await driverApi.getBooking();
  }

  void clearSettings() {
    hasOrder.value = false;
    isLoaded = false;
    loadedPendingOrders.value = false;
    pendingOrders.clear();
  }
}
