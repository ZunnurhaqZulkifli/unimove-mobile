import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/booking_controller.dart';
import 'package:unimove/controllers/driver_order_controller.dart';
import 'package:unimove/controllers/order_controller.dart';
import 'package:unimove/models/order.dart';
import 'package:unimove/pages/booking_destination_page.dart';
import 'package:unimove/pages/active_orders_page.dart';
import 'package:unimove/themes/theme.dart';
import 'package:unimove/themes/theme_controller.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  ThemeController themeController = Get.find();
  BookingController bookingController = Get.put(BookingController());
  BaseAppController controller = Get.find();
  OrderController orderController = Get.find();
  DriverOrderController _driverController = Get.find();

  @override
  void initState() {
    super.initState();
    bookingController.onInit();
    bookingController.checkHasBooking();

    if(controller.user?.type == 'driver') {
      _driverController.load();
    }

    orderController.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Obx(
          () => !baseAppController.hasOrder.value
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select a drop off location',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // if (controller.destinationController.destinations.isNotEmpty)
                        Column(
                          children:
                              controller.destinationController.destinations
                                  .map(
                                    (destination) => ListTile(
                                      style: ListTileStyle.drawer,
                                      visualDensity: VisualDensity(
                                        horizontal: 1,
                                        vertical: 2,
                                      ),
                                      dense: true,
                                      title: Text(
                                        destination.name!,
                                        style: TextStyle(
                                          color: ThemeColors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'RM ' + destination.price!,
                                        style: TextStyle(
                                          color: ThemeColors.primary1,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: Icon(
                                        size: 30,
                                        UniconsLine.arrow_right,
                                      ),
                                      onTap: () => Get.to(
                                        () => BookingDestination(
                                          appController: controller,
                                          destination: destination,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        )
                    ],
                  ),
                )
              : (orderController.currentOrder?.status == 'New') ? WaitOrder(order: orderController.currentOrder) : ActiveOrderPage(), // api calls here
        ),
      ),
    );
  }
}


class WaitOrder extends StatefulWidget {
  final Order? order;
  const WaitOrder({super.key, required this.order});

  @override
  State<WaitOrder> createState() => _WaitOrderState();
}

class _WaitOrderState extends State<WaitOrder> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ThemeColors.primary1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You have an active order',
              style: TextStyle(
                color: ThemeColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Please wait for the driver to accept your order',
              style: TextStyle(
                color: ThemeColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}