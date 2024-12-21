import 'package:get/get.dart';
import 'package:unimove/api/api.dart';

class DestinationController extends GetxController {
  bool isLoaded = false;
  RxList<Destination> destinations = <Destination>[].obs;

  Future loadDestinations() async {
    await api.getDestinations();
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

class Destination {
  String? id;
  String? name;
  String? code;
  String? address;
  String? price;
  String? estimation_time;
  String? status;
  String? image;

  Destination({
    required this.id,
    required this.name,
    required this.code,
    required this.address,
    required this.price,
    required this.estimation_time,
    required this.status,
    required this.image,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'].toString(),
      name: json['name'].toString(),
      code: json['code'].toString(),
      address: json['address'].toString(),
      price: json['price'].toString(),
      estimation_time: json['estimation_time'].toString(),
      status: json['status'].toString(),
      image: json['image'].toString(),
    );
  }

  void findName() {
    print('Name: ${name}');
  }
}
