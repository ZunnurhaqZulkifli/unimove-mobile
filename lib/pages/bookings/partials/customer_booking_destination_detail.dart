import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/controllers/customer_booking_controller.dart';

class DestinationDetail extends StatefulWidget {
  final Booking? booking;
  const DestinationDetail({super.key, this.booking});

  @override
  State<DestinationDetail> createState() => _DestinationDetailState();
}

class _DestinationDetailState extends State<DestinationDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.width * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Destination Details'),
            Text(
              'Pickup From : ${widget.booking?.bookingDetails?.pickup?.name}',
              style: TextStyle(
                color: const Color.fromARGB(255, 221, 209, 209),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Drop Off To : ${widget.booking?.bookingDetails?.dropOff?.name}',
              style: TextStyle(
                color: const Color.fromARGB(255, 221, 209, 209),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Distance : ${widget.booking?.bookingDetails?.distance}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Estimated Time : ${widget.booking?.bookingDetails?.estimation_time}' +
                  ' minute',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Price : ${widget.booking?.bookingDetails?.price}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
