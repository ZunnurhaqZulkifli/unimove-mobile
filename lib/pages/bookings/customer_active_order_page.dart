import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/customer_order_controller.dart';
import 'package:unimove/models/order.dart';
import 'package:unimove/themes/theme.dart';

class CustomerActiveOrder extends StatefulWidget {
  const CustomerActiveOrder({super.key});

  @override
  State<CustomerActiveOrder> createState() => _CustomerActiveState();
}

class _CustomerActiveState extends State<CustomerActiveOrder> {
  final BaseAppController controller = Get.find();
  Order? order;

  @override
  void initState() {
    super.initState();
    controller.customerOrderController.isLoaded.value = false;
    controller.customerOrderController.loadOrder();

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        order = controller.customerOrderController.order.value;
      });
    });
  }

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
            SizedBox(height: 10),
            ElevatedButton(onPressed: () async {
              await customerApi.cancelOrder(
                controller.customerOrderController,
                order!.id
              );
            }, child: Text('Cancel Order'), style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red
            ),)
          ],
        ),
      ),
    );
  }
}
