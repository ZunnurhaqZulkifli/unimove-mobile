import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/wallet_controller.dart';
import 'package:unimove/themes/theme_controller.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

ThemeController themeController = Get.find();
WalletController walletController = Get.find();
BaseAppController controller = Get.find();

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    super.initState();
    walletController.loadWallet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 150,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                      ),
                      Text(
                        ' RM ${controller.user!.wallet!.balance!.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => TopUpWallet());
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopUpWallet extends StatefulWidget {
  const TopUpWallet({super.key});

  @override
  State<TopUpWallet> createState() => _TopUpWalletState();
}

class _TopUpWalletState extends State<TopUpWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Up Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Text('Top Up Wallet'),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // walletController.topUpWallet(0.0);
              },
              child: Text('Top Up'),
            ),
          ],
        ),
      ),
    );
  }
}
