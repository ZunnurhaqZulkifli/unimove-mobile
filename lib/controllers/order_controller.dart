import 'package:get/get.dart';
import 'package:unimove/api/api.dart';
import 'package:unimove/models/order.dart';

class OrderController extends GetxController {
  bool isLoaded = false;
  RxList<Order> orders = <Order>[].obs;
  Order? currentOrder;

  Future load() async {
    print('loading user active order...');
    await api2.getMyCurrentOrder();
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

  void clearSettings() {
    isLoaded = false;
    orders.clear();
    currentOrder = null;
    orders.clear();
  }
}
