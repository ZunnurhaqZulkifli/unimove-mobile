import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/themes/theme_controller.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Column(
          children: [
            Center(
              child: Text('Recent Booking'),
            ),
            SizedBox(
              height: 4 * 100,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Order $index'),
                    subtitle: Text('Order $index details'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
