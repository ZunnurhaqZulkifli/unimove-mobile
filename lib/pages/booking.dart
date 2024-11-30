import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/booking_controller.dart';
import 'package:unimove/controllers/destination_controller.dart';
import 'package:unimove/themes/theme_controller.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  ThemeController themeController = Get.find();
  BookingController controller = Get.put(BookingController());
  BaseAppController baseAppController_ = Get.find();

  @override
  void initState() {
    super.initState();
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Obx(
          () => (controller.destinationController.destinations.isNotEmpty)
              ? Column(
                  children: controller.destinationController.destinations
                      .map(
                        (destination) => ListTile(
                          title: Text(destination.name!),
                          subtitle: Text(destination.address!),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () => Get.to(
                            () => BookingDestination(
                              appController: baseAppController_,
                              destination: destination,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              : Container(),
        ),
      ),
    );
  }
}

class BookingDestination extends StatefulWidget {
  final Destination destination;
  final BaseAppController appController;
  const BookingDestination(
      {super.key, required this.destination, required this.appController});

  @override
  State<BookingDestination> createState() => _BookingDestinationState();
}

class _BookingDestinationState extends State<BookingDestination> {
  @override
  void initState() {
    super.initState();

    print('Destination: ${widget.destination.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.destination.name!,
          style: ThemeController().currentTheme.textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    child: Image(
                      image: AssetImage(
                        'assets/images/login.png',
                      ),
                    ),
                  ),
                  Text('Address: ${widget.destination.address}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        child: Text('Back'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () => BookingController().book(
                          destination: widget.destination,
                        ),
                        child: Text('Book'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
