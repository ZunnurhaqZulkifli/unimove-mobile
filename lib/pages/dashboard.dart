import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:unimove/pages/home.dart';
import 'package:unimove/pages/order.dart';
import 'package:unimove/pages/profile.dart';
import 'package:unimove/pages/wallet.dart';
import 'package:unimove/themes/theme.dart';
import 'package:unimove/themes/theme_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selected_index = 0;
  int current_index = 0;
  late PageController page_controller;
  ThemeController themeController = Get.find();

  @override
  void initState() {
    super.initState();
    page_controller = PageController();
  }

  @override
  void dispose() {
    page_controller.dispose();
    super.dispose();
  }

  List<String> titles = ['Home', 'Order', 'Wallet', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[current_index],
          style: themeController.currentTheme.textTheme.displayLarge,
        ),
      ),
      // extendBodyBehindAppBar: true,
      body: SizedBox.expand(
        child: PageView(
          controller: page_controller,
          onPageChanged: (index) {
            setState(() => current_index = index);
          },
          children: <Widget>[
            HomePage(),
            OrderPage(),
            WalletPage(),
            ProfilePage()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: ThemeColors.primary1,
        itemCornerRadius: 25,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        showElevation: true,
        containerHeight: 60,
        selectedIndex: current_index,
        onItemSelected: (index) {
          setState(() => current_index = index);
          page_controller.jumpToPage(index);
        },
        animationDuration: Duration(milliseconds: 400),
        curve: Curves.fastEaseInToSlowEaseOut,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text('Home'),
            textAlign: TextAlign.center,
            icon: Icon(UniconsLine.home),
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
          BottomNavyBarItem(
            title: Text('Book'),
            icon: Icon(UniconsLine.location_arrow),
            textAlign: TextAlign.center,
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
          BottomNavyBarItem(
            title: Text('Wallet'),
            icon: Icon(UniconsLine.wallet),
            textAlign: TextAlign.center,
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
          BottomNavyBarItem(
            title: Text('Profile'),
            icon: Icon(UniconsLine.setting),
            textAlign: TextAlign.center,
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
        ],
      ),
    );
  }
}
