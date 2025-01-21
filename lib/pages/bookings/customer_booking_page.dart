import 'package:unimove/pages/bookings/customer_active_order_page.dart';
import 'package:unimove/pages/bookings/customer_booking_destination_page.dart';
import 'package:unimove/pages/bookings/customer_active_booking_page.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/themes/theme.dart';
import 'package:flutter/material.dart';
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
                      ListBody(
                        children: List.generate(
                          controller.destinationController.destinations.length,
                          (index) => InkWell(
                            onTap: () {
                              Get.to(
                                () => BookingDestination(
                                  appController: controller,
                                  destination: controller.destinationController
                                      .destinations[index],
                                ),
                              );
                            },
                            child: Container(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller.destinationController
                                                  .destinations[index].name!,
                                              style: TextStyle(
                                                color: ThemeColors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '~ RM ' +
                                                  controller
                                                      .destinationController
                                                      .destinations[index]
                                                      .price!,
                                              style: TextStyle(
                                                color: ThemeColors.black100,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        ' > ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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
