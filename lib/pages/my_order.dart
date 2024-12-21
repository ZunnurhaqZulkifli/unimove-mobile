import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/booking_controller.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

final BookingController bookingController = Get.find();
final BaseAppController controller = Get.find();

class _MyOrderState extends State<MyOrder> {
  Booking? booking;

  @override
  void initState() {
    super.initState();
    if (controller.hasOrder.value == false) {
      bookingController.getBooking();
    }

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        booking = bookingController.booking.first;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height / 3.6,
            child: Column(
              children: [
                Text(
                  'My Order',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_maps.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 200,
                width: double.infinity,
              ),
            ),
              ],
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: Get.height / 1.5,
              child: Obx(
                () => bookingController.isLoaded.value && booking != null
                    ? Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                          ),
                          Container(
                            width: double.infinity,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Booking Details'),
                                  Text(booking!.bookingDetails!.distance ?? ''),
                                  Text('id : ' + booking!.bookingDetails!.id.toString()),
                                  Text('reference_code : ' + booking!.bookingDetails!.reference_code.toString()),
                                  Text('user_id : ' + booking!.bookingDetails!.user_id.toString()),
                                  Text('booking_id : ' + booking!.bookingDetails!.booking_id.toString()),
                                  Text('driver_id : ' + booking!.bookingDetails!.driver_id.toString()),
                                  Text('vehicle_id : ' + booking!.bookingDetails!.vehicle_id.toString()),
                                  Text('user_wallet_id : ' + booking!.bookingDetails!.user_wallet_id.toString()),
                                  Text('driver_wallet_id : ' + booking!.bookingDetails!.driver_wallet_id.toString()),
                                  Text('destination_id : ' + booking!.bookingDetails!.destination_id.toString()),
                                  Text('pickup_from : ' + booking!.bookingDetails!.pickup_from.toString()),
                                  Text('pickup_time : ' + booking!.bookingDetails!.pickup_time.toString()),
                                  Text('dropoff_to : ' + booking!.bookingDetails!.dropoff_to.toString()),
                                  Text('dropoff_time : ' + booking!.bookingDetails!.dropoff_time.toString()),
                                  Text('cancellable : ' + booking!.bookingDetails!.cancellable.toString()),
                                  Text('reason : ' + booking!.bookingDetails!.reason.toString()),
                                  Text('price : ' + booking!.bookingDetails!.price.toString()),
                                  Text('estimation_time : ' + booking!.bookingDetails!.estimation_time.toString()),
                                  Text('distance : ' + booking!.bookingDetails!.distance.toString()),
                                  Text('created_at : ' + booking!.bookingDetails!.created_at.toString()),
                                  Text('updated_at : ' + booking!.bookingDetails!.updated_at.toString()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
              ),
            ),
          )
          // Container(
          //   width: double.infinity,
          //   child: Card(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text('My Order'),
          //         Text('Pickup From : '),
          //         Text('Drop Off To : '),
          //         Text('Estimated Time : '),
          //         Text('Distance : '),
          //         Text('Price : '),
          //         Text('--------'),
          //         Text('Booking'),
          //         Text('reference_code'),
          //         Text('status'),
          //         Text('order_id'),
          //         Text('accepted_by'),
          //         Text('created_at'),
          //         Text('updated_at'),
          //         Text('--------'),
          //         Text('Booking Details'),
          //         Text('reference_code'),
          //         Text('user_id'),
          //         Text('driver_id'),
          //         Text('vehicle_id'),
          //         Text('user_wallet_id'),
          //         Text('driver_wallet_id'),
          //         Text('destination_id'),
          //         Text('pickup_from'),
          //         Text('pickup_time'),
          //         Text('dropoff_to'),
          //         Text('dropoff_time'),
          //         Text('cancellable'),
          //         Text('reason'),
          //         Text('price'),
          //         Text('estimation_time'),
          //         Text('distance'),
          //         Text('created_at'),
          //         Text('updated_at'),
          //         Text('--------'),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(() => OrderPage());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
