import 'package:get/get.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/models/order.dart';

class CustomerOrderController extends GetxController {
  RxBool isLoaded = false.obs;
  RxBool hasOrder = false.obs;
  var order = Rxn<Order>();

  Future loadOrder() async {
    print('loading user active order...');
    await customerApi.getOrder();
  }

  Future checkHasOrder() async {
    if (await customerApi.checkHasOrder()) {
      await customerApi.getOrder();
    }
  }

  void clearSettings() {
    isLoaded.value = false;
    hasOrder.value = false;
    order = Rxn<Order>();
  }
}
