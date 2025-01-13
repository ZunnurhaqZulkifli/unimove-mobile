import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/booking_controller.dart';

// this is the page that will contain the order details

class ActiveOrderPage extends StatefulWidget {
  const ActiveOrderPage({super.key});

  @override
  State<ActiveOrderPage> createState() => _ActiveOrderPageState();
}

final BookingController bookingController = Get.find();
final BaseAppController controller = Get.find();

class _ActiveOrderPageState extends State<ActiveOrderPage> {
  Booking? booking;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () async {
      print(
        'has order is ' + controller.hasOrder.value.toString(),
      );
      await bookingController.getBooking();
    }).then((value) {
      setState(() {
        // booking = bookingController.booking.first;
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
                          BookingCard(booking: booking),
                          if (booking!.bookingDetails != null)
                            BookingDetailsCard(
                              booking: booking,
                            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(UniconsLine.location_point),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking? booking;
  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(booking!.reference_code ?? ''),
            Text('id : ' + booking!.id.toString()),
            Text('status : ' + booking!.status.toString()),
            Text('order_id : ' + booking!.order_id.toString()),
            Text('accepted_by : ' + booking!.accepted_by.toString()),
            Text('created_at : ' + booking!.created_at.toString()),
            Text('updated_at : ' + booking!.updated_at.toString()),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Booking Details'),
            Text(
              'reference_code : ' +
                  booking!.bookingDetails!.reference_code.toString(),
            ),
            Text(
              'driver_id : ' + booking!.bookingDetails!.driver_id.toString(),
            ),
            Text(
              'pickup_from : ' +
                  booking!.bookingDetails!.pickup_from.toString(),
            ),
            Text(
              'pickup_time : ' +
                  booking!.bookingDetails!.pickup_time.toString(),
            ),
            Text(
              'dropoff_to : ' + booking!.bookingDetails!.dropoff_to.toString(),
            ),
            Text(
              'price : ' + booking!.bookingDetails!.price.toString(),
            ),
            Text(
              'estimation_time : ' +
                  booking!.bookingDetails!.estimation_time.toString(),
            ),
            Text(
              'distance : ' + booking!.bookingDetails!.distance.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
