import 'package:unimove/pages/bookings/customer_active_order_page.dart';
import 'package:unimove/pages/bookings/customer_booking_destination_page.dart';
import 'package:unimove/pages/bookings/customer_active_booking_page.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:get/get.dart';

class CustomerBookingPage extends StatefulWidget {
  const CustomerBookingPage({super.key});

  @override
  State<CustomerBookingPage> createState() => _CustomerBookingPageState();
}

class _CustomerBookingPageState extends State<CustomerBookingPage> {
  BaseAppController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.customerOrderController.isLoaded.value = false;
    controller.customerOrderController.loadOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Obx(
          () => !controller.customerOrderController.hasOrder.value &&
                  controller.customerOrderController.order.value == null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select a pickup location',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // if (controller.destinationController.destinations.isNotEmpty)
                      Column(
                        children: controller.destinationController.destinations
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
                                  '~ RM ' + destination.price!,
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
              : (controller.customerOrderController.order.value?.status ==
                      'New')
                  ? CustomerActiveOrder()
                  : CustomerActiveBooking(), // api calls here
        ),
      ),
    );
  }
}
