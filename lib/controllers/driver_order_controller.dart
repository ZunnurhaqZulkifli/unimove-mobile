import 'package:get/get.dart';
import 'package:unimove/api/api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/models/order.dart';

class DriverOrderController extends GetxController {
  bool isLoaded = false;
  RxList<Order> orders = <Order>[].obs;
  RxList<Order> myOrders = <Order>[].obs;
  // BaseAppController baseAppController = Get.find();

  Future load() async {
    await api2.getOrders();
  }

  void setModel(List<dynamic> data) {
    orders.clear();

    for (var item in data) {
      orders.add(Order.fromJson(item));
    }
  }

  String findOrder(String? id) {
    for (var order in orders) {
      if (order.id == id) {
        return order.orderable_type!;
      }
    }

    return '';
  }

  void cancelOrder() {
    //
  }

  Future acceptOrder(Order? order) async {
    await api2.acceptOrder(order!.id!);

    baseAppController.hasOrder.value = true;
  }

  clearSettings() {
    isLoaded = false;
    orders.clear();
  }

  Future getAllOrders() async {
    await api2.getOrders(); // gets all the orders
  }
}
