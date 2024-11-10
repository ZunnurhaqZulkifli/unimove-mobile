import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/themes/theme_controller.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Text('Wallet Page'),
            ),
          ],
        ),
      ),
    );
  }
}
