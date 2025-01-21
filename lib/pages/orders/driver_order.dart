import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/driver_order_controller.dart';
import 'package:unimove/models/order.dart';
import 'package:unimove/pages/orders/driver_accept_order_page.dart';
import 'package:unimove/pages/orders/driver_active_orders_page.dart';

class DriverOrderPage extends StatefulWidget {
  const DriverOrderPage({super.key});

  @override
  State<DriverOrderPage> createState() => _DriverOrderPageState();
}

DriverOrderController driverOrderController = Get.find();
BaseAppController controller = Get.find();
bool hasLoaded = false;
RxList pendingOrders = <Order>[].obs;

class _DriverOrderPageState extends State<DriverOrderPage> {
  @override
  void initState() {
    super.initState();

    setState(() {
      controller.driverOrderController.hasOrder.value = false;
    });

    controller.driverOrderController.loadUnverifiedOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => controller.driverOrderController.hasOrder.value
                ? Center(
                    child: ActiveDriverPage(),
                  )
                : controller.driverOrderController.pendingOrders.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select an order to accept 📍 🙋',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListBody(
                                children: List.generate(
                                    driverOrderController.pendingOrders.length,
                                    (index) => InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => AcceptDriverOrderPage(
                                                driverOrderController:
                                                    driverOrderController,
                                                order: driverOrderController
                                                    .pendingOrders[index],
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            height: 100,
                                            width: double.infinity,
                                            child: Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'From : ' +
                                                              controller
                                                                  .destinationController
                                                                  .findDestination(
                                                                driverOrderController
                                                                    .pendingOrders[
                                                                        index]
                                                                    .pickup_from,
                                                              ),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Drop To : ' +
                                                              controller
                                                                  .destinationController
                                                                  .findDestination(
                                                                driverOrderController
                                                                    .pendingOrders[
                                                                        index]
                                                                    .dropoff_to,
                                                              ),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      ' > ',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 25,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                              )
                            ]),
                      )
                    : Container(
                        child: Center(
                          child: Text('No Orders Available. 🥲'),
                        ),
                      ),
          )),
    );
  }
}
