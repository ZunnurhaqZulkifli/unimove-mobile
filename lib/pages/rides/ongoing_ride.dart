import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/customer_booking_controller.dart';
import 'package:unimove/pages/dashboard.dart';
import 'package:unimove/pages/settings/maintainance_mode.dart';

class OngoingRidePage extends StatefulWidget {
  final Booking booking;
  const OngoingRidePage({super.key, required this.booking});

  @override
  State<OngoingRidePage> createState() => _OngoingRidePageState();
}

class _OngoingRidePageState extends State<OngoingRidePage> {
  BaseAppController controller = Get.find();

  @override
  void initState() {
    super.initState();
    print(controller.user.value?.type);

    if (controller.user.value?.type == 'driver') {
      driverApi.onGoingRide(widget.booking.id!);
    }

    if (controller.user.value?.type == 'student' ||
        controller.user.value?.type == 'staff') {
      customerApi.onGoingRide(widget.booking.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'On Going Ride',
          style: themeController.currentTheme.textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  'On Going Ride',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.customerBookingController.clearSettings();
                    Get.to(() => Dashboard());
                  },
                  child: Text(
                    'End Ride',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        (controller.user.value?.type == 'driver')
            ? Container(
                padding: const EdgeInsets.all(2),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.user.value?.type == 'driver') {
                      await driverApi.completeRide(widget.booking.id!);
                    }

                    if (controller.user.value?.type == 'student' ||
                        controller.user.value?.type == 'staff') {
                      await customerApi.completeRide(widget.booking.id!);
                    }

                    Get.to(() => Dashboard());
                  },
                  child: Text(
                    'Complete',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
