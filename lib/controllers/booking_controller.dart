import 'package:get/get.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/destination_controller.dart';

class BookingController extends GetxController {
  bool isLoaded = false;
  DestinationController destinationController = Get.find();
  BaseAppController baseAppController = Get.find();

  @override
  void onInit() {
    super.onInit();
    getBooking();
  }

  void getBooking() {
    //
  }

  void book({Destination? destination}) {
    if (baseAppController.user!.wallet!.balance! > 5.00) {
      print('Booking successful');

      // picked up from
      // picked up to
    } else {
      print('Insufficient funds');
    }
  }

  void cancelBooking() {
    //
  }

  void completeBooking() {
    //
  }
}
