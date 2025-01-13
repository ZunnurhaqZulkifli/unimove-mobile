import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/driver_order_controller.dart';
import 'package:unimove/models/order.dart';
import 'package:unimove/pages/driver_accept_order_page.dart';

class DriverOrderPage extends StatefulWidget {
  const DriverOrderPage({super.key});

  @override
  State<DriverOrderPage> createState() => _DriverOrderPageState();
}

DriverOrderController driverOrderController = Get.find();
BaseAppController controller = Get.find();
bool hasLoaded = false;
RxList orders = <Order>[].obs;

class _DriverOrderPageState extends State<DriverOrderPage> {
  @override
  void initState() {
    super.initState();

    getAllOrders();
  }

  Future<void> getAllOrders() async {
    await controller.driverOrderController.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() => controller.driverOrderController.orders.isNotEmpty ? 
          SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select an order to accept',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListBody(
                        children: List.generate(
                          driverOrderController.orders.length,
                          (index) => ListTile(
                            title: Text(
                              'From : ' +
                                  controller.destinationController
                                      .findDestination(
                                    driverOrderController
                                        .orders[index].pickup_from,
                                  ),
                            ),
                            subtitle: Text(
                              'Drop To : ' +
                                  controller.destinationController
                                      .findDestination(
                                    driverOrderController
                                        .orders[index].dropoff_to,
                                  ),
                            ),
                            horizontalTitleGap: 10,
                            trailing: Icon(Icons.arrow_forward_ios),
                            leading: Icon(UniconsLine.location_point),
                            onTap: () {
                              Get.to(
                                () => AcceptDriverOrderPage(
                                  driverOrderController: driverOrderController,
                                  order: driverOrderController.orders[index],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ]),
              )
            : Center(child: CircularProgressIndicator.adaptive()))
      ),
    );
  }
}
