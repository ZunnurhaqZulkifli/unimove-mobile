import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:unimove/controllers/customer_booking_controller.dart';
import 'package:unimove/pages/bookings/customer_active_booking_page.dart';
import 'package:unimove/pages/bookings/partials/customer_booking_destination_detail.dart';
import 'package:unimove/themes/theme.dart';

class OrderDetailButtons extends StatelessWidget {
  final Booking? booking;
  const OrderDetailButtons({super.key, this.booking});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Get.dialog(
            Dialog(
              backgroundColor: ThemeColors.grey100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: DriverDetailPage(booking: booking),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(2),
            width: Get.width / 2 - 85,
            height: Get.width / 2 - 85,
            child: Card(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      UniconsLine.streering,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      'Driver Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => Get.dialog(
            Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: ThemeColors.grey100,
              child: DestinationDetail(booking: booking),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(2),
            width: Get.width / 2 - 85,
            height: Get.width / 2 - 85,
            child: Card(
              color: ThemeColors.blue60,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      UniconsLine.location_pin_alt,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      'Destination Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => Get.dialog(
            Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: ThemeColors.grey100,
              child: DriverVerification(booking: booking),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(2),
            width: Get.width / 2 - 85,
            height: Get.width / 2 - 85,
            child: Card(
              color: ThemeColors.green100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      UniconsLine.check,
                      color: Colors.white,
                      size: 40,
                    ),
                    Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DriverDetailPage extends StatelessWidget {
  final Booking? booking;
  const DriverDetailPage({super.key, this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Driver Details',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Name : ${booking?.bookingDetails?.driver?.name}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            Text(
              'Phone Number : ${booking?.bookingDetails?.driver?.phone}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            Text(
              'Rating : ${booking?.bookingDetails?.driver?.ratings}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            Text(
              'Driver Id : ${booking?.bookingDetails?.driver?.driver_id}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 0.5,
            ),
            Text(
              'Vehicle Details',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Brand : ${booking?.bookingDetails?.vehicle?.brand?.name}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
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
            Text(
              'Color : ${booking?.bookingDetails?.vehicle?.color}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
