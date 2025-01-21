import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unicons/unicons.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/models/dashboaed_images.dart';
import 'package:unimove/pages/cms-content.dart';
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
  List<DashboardImage> images = [];
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    setState(() {
      images = controller.dashboardController.dashboardImages;
    });

    loadWallets();
  }

  void loadWallets() async {
    await userApi.getWallet();
  }

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
                  'Hi , ' +
                      (controller.user.value?.name != null &&
                              controller.user.value!.name!.length > 20
                          ? controller.user.value!.name!.substring(0, 20)
                          : controller.user.value?.name ?? ''),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
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
                              ' RM ${controller.user.value?.wallet!.balance!.toStringAsFixed(2)}',
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
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: 200,
              child: PageView(
                controller: pageController,
                children: List.generate(images.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      width: double.infinity - 20,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            Uri.parse(
                              ENDPOINT + '/' + images[index].path.toString(),
                            ).toString(),
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: images.length,
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
            QuickIcons()
          ],
        ),
      ),
    );
  }
}

class QuickIcons extends StatefulWidget {
  const QuickIcons({super.key});

  @override
  QuickIconsState createState() => QuickIconsState();
}

class QuickIconsState extends State<QuickIcons> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 3.0,
                bottom: 3.0,
                left: 12.0,
              ),
              child: Text(
                'Quick Links',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(
              width: Get.width / 3 - 20,
              height: Get.width / 3 - 20,
              child: InkWell(
                onTap: () {
                  Get.to(() => CmsContentPage(
                        'https://brighten.uniten.edu.my/login/index.php',
                        'Brighten',
                      ));
                },
                child: Card(
                  color: ThemeColors.primary1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        UniconsLine.brain,
                        color: Colors.white,
                      ),
                      Text(
                        'Brighten \n Portal ⭐️',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Get.width / 3 - 20,
              height: Get.width / 3 - 20,
              child: InkWell(
                onTap: () {
                  Get.to(() => CmsContentPage(
                        'https://www.uniten.edu.my/student-hub/',
                        'Student Info',
                      ));
                },
                child: Card(
                  color: ThemeColors.primary1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        UniconsLine.book,
                        color: Colors.white,
                      ),
                      Text(
                        'Student \n Info ℹ️',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Get.width / 3 - 20,
              height: Get.width / 3 - 20,
              child: InkWell(
                onTap: () {
                  Get.to(() => CmsContentPage(
                        'https://www.uniten.edu.my/campus-life/services-facilities/transportation/?gad_source=1&gbraid=0AAAAApvmCrjG0PS7ueCjQSs7gQP26HY8e&gclid=EAIaIQobChMIjKja_bf6igMVoahmAh1vLCjtEAAYASAAEgKYGfD_BwE',
                        'Uniten Shuttle',
                      ));
                },
                child: Card(
                  color: ThemeColors.primary1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        UniconsLine.clock,
                        color: Colors.white,
                      ),
                      Text(
                        'Uniten \n Shuttle  🚌',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
