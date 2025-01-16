import 'package:get/get.dart';
import 'package:unimove/api/user_api.dart';

class WalletController extends GetxController {
  var balance = 0.0.obs;

  void loadWallet() async {
    await customerApi.getWallet();
  }

  void topUpWallet(double amount) async {
    // await api2.topUpWallet(amount);
  }
}
