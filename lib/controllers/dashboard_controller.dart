import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/models/user.dart';
import 'package:unimove/pages/home.dart';
import 'package:unimove/pages/booking.dart';
import 'package:unimove/pages/profile.dart';
import 'package:unimove/pages/unverified_home.dart';
import 'package:unimove/pages/wallet.dart';
import 'package:unimove/themes/theme.dart';

class DashboardController extends GetxController {
  RxString type = ''.obs;
  RxList<dynamic> pages = [].obs;
  bool verified = false;
  late Rx<User> user;
  late BaseAppController controller;
  RxBool isLoaded = true.obs;

  void initialize({BaseAppController? controller}) {
    this.controller = controller!;

    user = controller.user!.obs;
    type.value = user.value.type!;

    verified = controller.user!.verified;

    setRoutes();
  }

  void setRoutes() {
    print('user type: ${type.value}');

    if (type.value == 'student' && verified) {
      print('user type is student');
      verifiedStudentPage();
    }

    if (type.value == 'driver' && verified) {
      print('user type is driver');
      verifiedDriverPage();
    }

    if (!verified) {
      print('user is unverified');
      unverifiedPage();
    }
  }

  void verifiedStudentPage() {
    pages.clear();

    pages.addAll(
      [
        {
          'title': 'Home',
          'route': '/home',
          'page': HomePage(),
          'tab': BottomNavyBarItem(
            title: Text('Home'),
            textAlign: TextAlign.center,
            icon: Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Icon(UniconsLine.home),
            ),
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
        },
        {
          'title': 'Book',
          'route': '/book',
          'page': BookingPage(),
          'tab': BottomNavyBarItem(
            title: Text('Book'),
            textAlign: TextAlign.center,
            icon: Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Icon(UniconsLine.car),
            ),
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
        },
        {
          'title': 'Wallet',
          'route': '/wallet',
          'page': WalletPage(),
          'tab': BottomNavyBarItem(
            title: Text('Wallet'),
            textAlign: TextAlign.center,
            icon: Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Icon(UniconsLine.wallet),
            ),
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
        },
        {
          'title': 'Profile',
          'route': '/profile',
          'page': ProfilePage(),
          'tab': BottomNavyBarItem(
            title: Text('Profile'),
            textAlign: TextAlign.center,
            icon: Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Icon(UniconsLine.user),
            ),
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
        },
      ],
    );

    if (pages.isNotEmpty) {
      print('pages are not empty');
      print(pages.length.toString());
      isLoaded.value = true;
    }
  }

  void verifiedDriverPage() {
    pages.clear();

    pages.addAll(
      [
        {
          'title': 'Home',
          'route': '/home',
          'page': HomePage(),
          'tab': BottomNavyBarItem(
            title: Text('Home'),
            textAlign: TextAlign.center,
            icon: Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Icon(UniconsLine.home),
            ),
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
        },
        {
          'title': 'Book',
          'route': '/book',
          'page': BookingPage(),
          'tab': BottomNavyBarItem(
            title: Text('Book'),
            textAlign: TextAlign.center,
            icon: Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Icon(UniconsLine.car),
            ),
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
        },
        {
          'title': 'Wallet',
          'route': '/wallet',
          'page': WalletPage(),
          'tab': BottomNavyBarItem(
            title: Text('Wallet'),
            textAlign: TextAlign.center,
            icon: Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Icon(UniconsLine.wallet),
            ),
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
        },
        {
          'title': 'Profile',
          'route': '/profile',
          'page': ProfilePage(),
          'tab': BottomNavyBarItem(
            title: Text('Profile'),
            textAlign: TextAlign.center,
            icon: Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Icon(UniconsLine.user),
            ),
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
        },
      ],
    );

    isLoaded.value = true;
  }

  void unverifiedPage() {
    pages.clear();

    pages.addAll(
      [
        {
          'title': 'Home',
          'route': '/home',
          'page': UnverifiedHomePage(),
          'tab': BottomNavyBarItem(
            title: Text('Home'),
            textAlign: TextAlign.center,
            icon: Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Icon(UniconsLine.home),
            ),
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
        },
        {
          'title': 'Profile',
          'route': '/profile',
          'page': ProfilePage(),
          'tab': BottomNavyBarItem(
            title: Text('Profile'),
            textAlign: TextAlign.center,
            icon: Padding(
              padding: const EdgeInsets.only(left: 1),
              child: Icon(UniconsLine.user),
            ),
            activeColor: ThemeColors.white,
            inactiveColor: ThemeColors.white,
          ),
        },
      ],
    );

    isLoaded.value = true;
  }

  void clearSettings() {
    type.value = '';
    pages.clear();
  }
}
