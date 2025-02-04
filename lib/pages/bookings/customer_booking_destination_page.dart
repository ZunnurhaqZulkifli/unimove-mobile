import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/controllers/base_app_controller.dart';
import 'package:unimove/controllers/customer_booking_controller.dart';
import 'package:unimove/models/destination.dart';
import 'package:unimove/pages/dashboard.dart';
import 'package:unimove/themes/theme.dart';
import 'package:unimove/themes/theme_controller.dart';

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

CustomerBookingController bookingController = Get.find();
ThemeController themeController = Get.find();
Map<String, dynamic> calculated_data = {};
bool is_expanded = false;

var selectedPickup;
var dropOff;

class _BookingDestinationState extends State<BookingDestination> {
  @override
  void initState() {
    super.initState();

    setState(() {
      calculated_data = {};
      selectedPickup = null;
      dropOff = widget.destination.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          widget.destination.name!,
          style: themeController.currentTheme.textTheme.displayLarge,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 110.0),
            child: Container(
              height: 200,
              width: Get.width,
              decoration: BoxDecoration(
                color: ThemeColors.primary1,
                image: DecorationImage(
                  image: NetworkImage(
                      ENDPOINT + '/' + widget.destination.image_l!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  if (selectedPickup != null)
                    ExpansionPanelList(
                      expansionCallback: (panelIndex, isExpanded) {
                        setState(() {
                          is_expanded = !is_expanded;
                        });
                      },
                      dividerColor: Colors.transparent,
                      children: [
                        ExpansionPanel(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          canTapOnHeader: true,
                          isExpanded: is_expanded,
                          headerBuilder: (context, isExpanded) {
                            return ListTile(
                              title: Text(
                                  'Drop Off To : ${bookingController.destinationController.findDestination(selectedPickup)}'),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  height: 150,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: ThemeColors.primary1,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(ENDPOINT +
                                            '/' +
                                            bookingController
                                                .destinationController
                                                .destinations
                                                .where(
                                                  (e) =>
                                                      e.id
                                                          .toString()
                                                          .toLowerCase() ==
                                                      selectedPickup
                                                          .toString()
                                                          .toLowerCase(),
                                                )
                                                .elementAt(0)
                                                .image_l!),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: Get.width,
                    child: Text(
                      'Drop off :',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    width: Get.width,
                    child: DropdownButton(
                      style: TextStyle(
                        color: ThemeColors.white,
                        wordSpacing: 2,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      isExpanded: true,
                      hint: Text('Drop Off To'),
                      value: selectedPickup,
                      isDense: false,
                      items: List.generate(
                        bookingController.destinationController.destinations
                            .where(
                              (e) =>
                                  e.name.toString().toLowerCase() !=
                                  widget.destination.name!
                                      .toString()
                                      .toLowerCase(),
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
                          value: bookingController
                              .destinationController.destinations
                              .where(
                                (e) =>
                                    e.name.toString().toLowerCase() !=
                                    widget.destination.name!
                                        .toString()
                                        .toLowerCase(),
                              )
                              .elementAt(index)
                              .id!,
                        ),
                      ),
                      onChanged: (value) async {
                        calculated_data = await customerApi.calculateData(
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
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pickup From : ${widget.destination.name}',
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
          ),
        ],
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
                  Duration(seconds: 2),
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
