import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/order_controller.dart';
import 'package:unimove/pages/dashboard.dart';
import 'package:unimove/themes/theme.dart';
import 'package:unimove/themes/theme_controller.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

OrderController orderController = Get.find();
BaseAppController controller = Get.find();

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    orderController.loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Select an order to accept',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListBody(
              children: List.generate(
                orderController.orders.length,
                (index) => ListTile(
                  title: Text(
                    'From : ' +
                        controller.destinationController.findDestination(
                          orderController.orders[index].pickup_from,
                        ),
                  ),
                  subtitle: Text(
                    'Drop To : ' +
                        controller.destinationController.findDestination(
                          orderController.orders[index].dropoff_to,
                        ),
                  ),
                  horizontalTitleGap: 10,
                  trailing: Icon(Icons.arrow_forward_ios),
                  leading: Icon(UniconsLine.location_point),
                  onTap: () {
                    Get.to(
                      () => AcceptOrderPage(
                        orderController: orderController,
                        order: orderController.orders[index],
                      ),
                    );
                  },
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class AcceptOrderPage extends StatefulWidget {
  final Order order;
  final OrderController orderController;

  const AcceptOrderPage({
    super.key,
    required this.order,
    required this.orderController,
  });

  @override
  State<AcceptOrderPage> createState() => _AcceptOrderPageState();
}

ThemeController themeController = Get.find();
Order? order;

class _AcceptOrderPageState extends State<AcceptOrderPage> {
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
              await widget.orderController.acceptOrder(order);

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

