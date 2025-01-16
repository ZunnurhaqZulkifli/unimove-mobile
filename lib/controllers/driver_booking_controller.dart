import 'package:get/get.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/controllers/customer_booking_controller.dart';
import 'package:unimove/controllers/destination_controller.dart';
// import 'package:unimove/helpers/snackbar_helpers.dart';

class DriverBookingController extends GetxController {
  RxBool isLoaded = false.obs;
  DestinationController destinationController = Get.find();
  RxBool isBookingLoaded = false.obs;
  RxBool onGoingRide = false.obs;
  var booking = Rxn<Booking>();

  Future loadBooking() async {
    print('loading driver booking...');
    await driverApi.getBooking();
  }

  void clearSettings() {
    isLoaded.value = false;
    booking = Rxn<Booking>();
    isBookingLoaded.value = false;
    onGoingRide.value = false;
  }
}
