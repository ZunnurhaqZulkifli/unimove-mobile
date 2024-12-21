import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/dashboard_controller.dart';
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
  PageController page_controller = PageController();
  ThemeController themeController = Get.find();
  BaseAppController baseAppController = Get.find();
  DashboardController controller = Get.find();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      controller.initialize(controller: baseAppController);
    });
  }

  @override
  void dispose() {
    page_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.pages.isNotEmpty)
          ? Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  controller.pages[current_index]['title'].toString(),
                  style: themeController.currentTheme.textTheme.displayLarge,
                ),
              ),
              body: SizedBox.expand(
                child: PageView(
                  controller: page_controller,
                  onPageChanged: (index) {
                    setState(() => current_index = index);
                  },
                  children: controller.pages.map((element) {
                    return element['page'] as Widget;
                  }).toList(),
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
                itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                animationDuration: Duration(milliseconds: 400),
                curve: Curves.fastEaseInToSlowEaseOut,
                items: controller.pages.map((element) {
                  return element['tab'] as BottomNavyBarItem;
                }).toList(),
              ),
            )
          : Scaffold(
              backgroundColor:
                  themeController.currentTheme.scaffoldBackgroundColor,
              body: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
    );
  }
}
