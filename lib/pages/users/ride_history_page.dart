import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/customer_booking_controller.dart';
import 'package:unimove/themes/theme_controller.dart';

class RideHistoryPage extends StatefulWidget {
  const RideHistoryPage({super.key});

  @override
  State<RideHistoryPage> createState() => _RideHistoryPageState();
}

ThemeController themeController = Get.find();
BaseAppController controller = Get.find();
double height = 100;

class _RideHistoryPageState extends State<RideHistoryPage> {
  @override
  void initState() {
    super.initState();
    loadUserHistory();
  }

  Future loadUserHistory() async {
    await userApi.getHistory();

    if (controller.historyBookings.isNotEmpty) {
      print('History loaded');
      controller.historyBookingsLoaded.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => controller.historyBookingsLoaded.value
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'List of previous rides 🚗 💨',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListBody(
                          children: List.generate(
                              controller.historyBookings.length, (index) {
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => RideDetailsPage(
                                controller: controller,
                                booking: controller.historyBookings[index],
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            height: height,
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      ' Form : ${controller.historyBookings[index].bookingDetails!.pickup!.name} \n Drop Off : ${controller.historyBookings[index].bookingDetails!.dropOff!.name}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      'RM ${controller.historyBookings[index].bookingDetails!.price}  > ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }))
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    'No ride history found ! \n 🥲',
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
      ),
    );
  }
}

class TopUpWallet extends StatefulWidget {
  const TopUpWallet({super.key});

  @override
  State<TopUpWallet> createState() => _TopUpWalletState();
}

class _TopUpWalletState extends State<TopUpWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Up Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Text('Top Up Wallet'),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // walletController.topUpWallet(0.0);
              },
              child: Text('Top Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class RideDetailsPage extends StatelessWidget {
  final Booking booking;
  final BaseAppController controller;
  const RideDetailsPage(
      {super.key, required this.booking, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ride Details',
          style: themeController.currentTheme.textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Card(
                child: Center(
                  child: Text(
                    '${booking.bookingDetails!.pickup!.name} to ${booking.bookingDetails!.dropOff!.name}',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Booking Time : ${booking.bookingDetails!.created_at}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Referral Code : ${booking.bookingDetails!.reference_code}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Vehicle Plate : ${booking.bookingDetails!.vehicle!.plate_no}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Milege : ${booking.bookingDetails!.vehicle!.mileage}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Distance : ${booking.bookingDetails!.distance} KM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Amount Paid : RM ${booking.bookingDetails!.price}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
