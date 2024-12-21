import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'package:unimove/api/api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/booking_controller.dart';
import 'package:unimove/controllers/destination_controller.dart';
import 'package:unimove/pages/dashboard.dart';
import 'package:unimove/pages/my_order.dart';
import 'package:unimove/themes/theme.dart';
import 'package:unimove/themes/theme_controller.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  ThemeController themeController = Get.find();
  BookingController bookingController = Get.put(BookingController());
  BaseAppController controller = Get.find();

  @override
  void initState() {
    super.initState();
    bookingController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Obx(
          () => controller.hasOrder.isTrue == false
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select a drop off location',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (controller
                          .destinationController.destinations.isNotEmpty)
                        Column(
                          children:
                              controller.destinationController.destinations
                                  .map(
                                    (destination) => ListTile(
                                      style: ListTileStyle.drawer,
                                      visualDensity: VisualDensity(
                                        horizontal: 1,
                                        vertical: 2,
                                      ),
                                      dense: true,
                                      title: Text(
                                        destination.name!,
                                        style: TextStyle(
                                          color: ThemeColors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'RM ' + destination.price!,
                                        style: TextStyle(
                                          color: ThemeColors.primary1,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: Icon(
                                        size: 30,
                                        UniconsLine.arrow_right,
                                      ),
                                      onTap: () => Get.to(
                                        () => BookingDestination(
                                          appController: controller,
                                          destination: destination,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        )
                    ],
                  ),
                )
              : MyOrder(), // OrderPage(),
        ),
      ),
    );
  }
}

class BookingDestination extends StatefulWidget {
  final Destination destination;
  final BaseAppController appController;

  const BookingDestination({
    super.key,
    required this.destination,
    required this.appController,
  });

  @override
  State<BookingDestination> createState() => _BookingDestinationState();
}

BookingController bookingController = Get.find();
ThemeController themeController = Get.find();
Map<String, dynamic> calculated_data = {};

var selectedPickup;
var dropOff;

class _BookingDestinationState extends State<BookingDestination> {
  @override
  void initState() {
    super.initState();
    print('Destination: ${widget.destination.name}');

    setState(() {
      calculated_data = {};
      selectedPickup = null;
      dropOff = widget.destination.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.destination.name!,
          style: themeController.currentTheme.textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Image(
                image: AssetImage(
                  'assets/images/login.png',
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 300,
              child: Text(
                'Pickup From :',
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: 300,
              child: DropdownButton(
                style: TextStyle(
                  color: ThemeColors.white,
                  wordSpacing: 2,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                isExpanded: true,
                hint: Text('Pickup From'),
                value: selectedPickup,
                // dropdownColor: Colors.white,
                isDense: false,
                items: List.generate(
                  bookingController.destinationController.destinations
                      .where(
                        (e) =>
                            e.name.toString().toLowerCase() !=
                            widget.destination.name!.toString().toLowerCase(),
                      )
                      .length,
                  (index) => DropdownMenuItem(
                    child: Text(
                      bookingController.destinationController.destinations
                          .where(
                            (e) =>
                                e.name.toString().toLowerCase() !=
                                widget.destination.name!
                                    .toString()
                                    .toLowerCase(),
                          )
                          .elementAt(index)
                          .name!,
                    ),
                    value: bookingController.destinationController.destinations
                        .where(
                          (e) =>
                              e.name.toString().toLowerCase() !=
                              widget.destination.name!.toString().toLowerCase(),
                        )
                        .elementAt(index)
                        .id!,
                  ),
                ),
                onChanged: (value) async {
                  calculated_data = await api2.calculateData(
                    value.toString(),
                    dropOff,
                  );
                  setState(() {
                    selectedPickup = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drop Off To : ${widget.destination.name}',
                    style: TextStyle(
                      color: ThemeColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  if (calculated_data.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estimated Time : ~ ${calculated_data['estimation_time']} Minutes',
                        ),
                        Text(
                          'Distance : ~ ${calculated_data['distance']} Km',
                        ),
                      ],
                    ),
                  Text(
                    'RM ${(calculated_data.isNotEmpty) ? calculated_data['price'].toStringAsFixed(2) : widget.destination.price}',
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
      floatingActionButton: OverflowBar(
        children: [
          ElevatedButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          SizedBox(
            width: 10,
          ),
          if (selectedPickup != null)
            ElevatedButton(
              onPressed: () async {
                await bookingController.book(
                  pickup_from: selectedPickup,
                  drop_off: dropOff,
                );

                Future.delayed(
                  Duration(seconds: 4),
                  () => Get.offAll(() => Dashboard()),
                );
              },
              child: Text('Book'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
        ],
      ),
    );
  }
}
