import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unicons/unicons.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/themes/theme.dart';
import 'package:unimove/themes/theme_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BaseAppController controller = Get.find();
  ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hi ${controller.user!.name},',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              UniconsLine.wallet,
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
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            title: Text('Top Up Wallet'),
                            content: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Amount',
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Top Up'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: ThemeColors.green100,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                UniconsLine.plus,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            PhotoCarousel(),
          ],
        ),
      ),
    );
  }
}

class PhotoCarousel extends StatefulWidget {
  const PhotoCarousel({super.key});

  @override
  PhotoCarouselState createState() => PhotoCarouselState();
}

class PhotoCarouselState extends State<PhotoCarousel> {
  PageController pageController = PageController();

  List<Widget> photoWidgets = [
    SizedBox(
      width: 100,
      height: 100,
      child: Card(
        color: ThemeColors.primary1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    SizedBox(
      width: 100,
      height: 100,
      child: Card(
        color: ThemeColors.primary1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    SizedBox(
      width: 100,
      height: 100,
      child: Card(
        color: ThemeColors.primary1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    SizedBox(
      width: 100,
      height: 100,
      child: Card(
        color: ThemeColors.primary1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    SizedBox(
      width: 100,
      height: 100,
      child: Card(
        color: ThemeColors.primary1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    SizedBox(
      width: 100,
      height: 100,
      child: Card(
        color: ThemeColors.primary1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          width: double.infinity,
          height: 230,
          child: PageView(
            controller: pageController,
            children: photoWidgets,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SmoothPageIndicator(
          controller: pageController,
          count: 6,
          axisDirection: Axis.horizontal,
          effect: SlideEffect(
            spacing: 10,
            radius: 10,
            dotWidth: 10.0,
            dotHeight: 10.0,
            paintStyle: PaintingStyle.stroke,
            strokeWidth: 0.8,
            dotColor: Colors.grey,
            activeDotColor: ThemeColors.red3,
          ),
        ),
      ],
    );
  }
}
