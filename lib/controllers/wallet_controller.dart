import 'package:get/get.dart';
import 'package:unimove/api/api.dart';

class WalletController extends GetxController {
  var balance = 0.0.obs;

  void loadWallet() async {
    await api2.getWallet();
  }

  void topUpWallet(double amount) async {
    // await api2.topUpWallet(amount);
  }
}
