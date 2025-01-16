import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/driver_order_controller.dart';
import 'package:unimove/themes/theme.dart';

class DriverActiveOrder extends StatefulWidget {
  const DriverActiveOrder({super.key});

  @override
  State<DriverActiveOrder> createState() => _DriverActiveOrderState();
}

class _DriverActiveOrderState extends State<DriverActiveOrder> {
  DriverOrderController driverOrderController =
      Get.put(DriverOrderController());

  BaseAppController controller = Get.find();

  @override
  void initState() {
    super.initState();

    if (controller.driverOrderController.hasOrder.value) {
      controller.driverOrderController.getBooking();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: 200,
              decoration: BoxDecoration(
                color: ThemeColors.red3,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Order Details',
                style: TextStyle(
                  color: ThemeColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
