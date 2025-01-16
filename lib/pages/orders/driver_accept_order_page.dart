import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/driver_order_controller.dart';
import 'package:unimove/models/order.dart';
import 'package:unimove/pages/dashboard.dart';
import 'package:unimove/themes/theme.dart';
import 'package:unimove/themes/theme_controller.dart';

class AcceptDriverOrderPage extends StatefulWidget {
  final Order order;
  final DriverOrderController driverOrderController;

  const AcceptDriverOrderPage({
    super.key,
    required this.order,
    required this.driverOrderController,
  });

  @override
  State<AcceptDriverOrderPage> createState() => _AcceptDriverOrderPageState();
}

BaseAppController controller = Get.find();
ThemeController themeController = Get.find();
Order? order;

class _AcceptDriverOrderPageState extends State<AcceptDriverOrderPage> {
  @override
  void initState() {
    super.initState();
    order = widget.order;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Accept Order',
          style: themeController.currentTheme.textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Accept Order'),
              Container(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup From : ${controller.destinationController.findDestination(order!.pickup_from)}',
                      style: TextStyle(
                        color: ThemeColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Drop Off To : ${controller.destinationController.findDestination(order!.dropoff_to)}',
                      style: TextStyle(
                        color: ThemeColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estimated Time : ~ ${widget.order.estimation_time} Minutes',
                        ),
                        Text(
                          'Distance : ~ ${widget.order.distance} Km',
                        ),
                      ],
                    ),
                    Text(
                      'RM ${double.tryParse(widget.order.price!.toString())!.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: ThemeColors.primary1,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: OverflowBar(
        children: [
          ElevatedButton(
            onPressed: () async {
              await widget.driverOrderController.acceptOrder(order);

              Future.delayed(Duration(seconds: 2), () {
                Get.offAll(() => Dashboard());
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Accept'),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
