import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/customer_booking_controller.dart';
import 'package:unimove/controllers/driver_booking_controller.dart';
import 'package:unimove/pages/bookings/partials/driver_booking_driver_detail.dart';
// import 'package:unimove/pages/bookings/partials/customer_booking_driver_detail.dart';

// this is the page that will contain the order details

class ActiveDriverPage extends StatefulWidget {
  const ActiveDriverPage({super.key});

  @override
  State<ActiveDriverPage> createState() => _ActiveDriverPageState();
}

final DriverBookingController bookingController = Get.find();
final BaseAppController controller = Get.find();

class _ActiveDriverPageState extends State<ActiveDriverPage> {
  Booking? booking;

  @override
  void initState() {
    super.initState();

    setState(() {
      controller.driverBookingController.isLoaded.value = false;
    });

    controller.driverBookingController.loadBooking();
    Future.delayed(Duration(seconds: 1), () async {}).then((value) {
      setState(() {
        booking = controller.driverBookingController.booking.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Order',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              child: Obx(
                () => bookingController.isLoaded.value && booking != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              width: Get.width - 30,
                              height: Get.width / 2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/google_maps.png',
                                  ),
                                  fit: BoxFit.fitWidth,
                                ),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: Get.width,
                            child: Text(
                              'Please proceed to the pickup location.',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          if (booking!.bookingDetails != null)
                            BookingDetailsCard(
                              booking: booking,
                            ),
                          OrderDetailButtonsDriver(booking: booking),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingDetailsCard extends StatelessWidget {
  final Booking? booking;
  const BookingDetailsCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 0.5,
              ),
              Text(
                'Booking Reference : ' +
                    booking!.bookingDetails!.reference_code.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Pickup : ' + booking!.bookingDetails!.pickup!.name.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Drop : ' + booking!.bookingDetails!.dropOff!.name.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Profit : RM ' + booking!.bookingDetails!.price.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Time Est : ' +
                    booking!.bookingDetails!.estimation_time.toString() +
                    ' Minutes',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Distance : ' +
                    booking!.bookingDetails!.distance.toString() +
                    ' KM',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
