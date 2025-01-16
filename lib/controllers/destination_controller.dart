import 'package:get/get.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/models/destination.dart';

class DestinationController extends GetxController {
  bool isLoaded = false;
  RxList<Destination> destinations = <Destination>[].obs;

  Future loadDestinations() async {
    await userApi.getDestinations();
  }

  void setDestinationsModel(List<dynamic> data) {
    destinations.clear();

    for (var item in data) {
      destinations.add(Destination.fromJson(item));
    }
  }

  String findDestination(String? id) {
    for (var destination in destinations) {
      if (destination.id == id) {
        return destination.name!;
      }
    }

    return '';
  }

  void clearSettings() {
    isLoaded = false;
    destinations.clear();
  }
}
