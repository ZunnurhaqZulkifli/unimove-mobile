import 'package:unimove/controllers/base_app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/controllers/customer_booking_controller.dart';
import 'package:unimove/pages/bookings/partials/customer_booking_driver_detail.dart';
import 'package:unimove/pages/rides/ongoing_ride.dart';

class CustomerActiveBooking extends StatefulWidget {
  const CustomerActiveBooking({super.key});

  @override
  State<CustomerActiveBooking> createState() => _CustomerActiveBookingState();
}

class _CustomerActiveBookingState extends State<CustomerActiveBooking> {
  final BaseAppController controller = Get.find();
  Booking? booking;

  @override
  void initState() {
    super.initState();
    controller.customerBookingController.isLoaded.value = false;
    controller.customerBookingController.loadBooking();

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        booking = controller.customerBookingController.booking.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(
          () => controller.customerBookingController.isLoaded.value &&
                  booking != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Ongoing Booking',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              'Plate : ${booking?.bookingDetails?.vehicle?.plate_no}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: Get.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/gifs/waiting_car.gif',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Please wait for the driver to arrive, once the driver arrives, click verify.',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trip Details',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Pickup From : ${booking?.bookingDetails?.pickup?.name}',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 221, 209, 209),
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Drop Off To : ${booking?.bookingDetails?.dropOff?.name}',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 221, 209, 209),
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Estimated Time : ${booking?.bookingDetails?.estimation_time}' +
                                ' minute',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Price : ${booking?.bookingDetails?.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Model : ${booking?.bookingDetails?.vehicle?.model?.name}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Plate Number : ${booking?.bookingDetails?.vehicle?.plate_no}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    OrderDetailButtons(booking: booking),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}

class DriverVerification extends StatelessWidget {
  final Booking? booking;

  const DriverVerification({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: Get.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Reminder : Please Ask the driver for the verification code, if it matches the code below, click verify and continue with your ride, if the code does not match, please do not proceed with the ride.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Verification Code',
            style: TextStyle(
              fontSize: 15,
              // fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            booking?.reference_code ?? '',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: Size(
                    100,
                    20,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text('Back'),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: Size(
                    100,
                    20,
                  ),
                ),
                onPressed: () {
                  Get.offAll(() => OngoingRidePage(
                        booking: booking!,
                      ));
                },
                child: Text('Verify'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomerVerification extends StatelessWidget {
  final Booking? booking;

  const CustomerVerification({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: Get.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Reminder : Please Ask the customer for the verification code, if it matches the code below, click verify and continue with your ride, if the code does not match, please do not proceed with the ride.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Verification Code',
            style: TextStyle(
              fontSize: 15,
              // fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            booking?.reference_code ?? '',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: Size(
                    100,
                    20,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text('Back'),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: Size(
                    100,
                    20,
                  ),
                ),
                onPressed: () {
                  Get.offAll(() => OngoingRidePage(
                        booking: booking!,
                      ));
                },
                child: Text('Verify'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
