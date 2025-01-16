import 'package:get/get.dart';
import 'package:unimove/api/user_api.dart';
import 'package:unimove/controllers/destination_controller.dart';
// import 'package:unimove/helpers/snackbar_helpers.dart';

class CustomerBookingController extends GetxController {
  RxBool isLoaded = false.obs;
  RxBool hasBooking = false.obs;
  RxBool onGoingRide = false.obs;
  DestinationController destinationController = Get.find();
  var booking = Rxn<Booking>();
  // need to set to true if user has booking // called user has orders in be

  Future loadBooking() async {
    print('loading user active booking...');
    await customerApi.getBooking();
  }

  Future checkHasBooking() async {
    if (await customerApi.checkHasBooking()) {
      customerApi.getBooking();
    }
  }

  Future book({String? drop_off, String? pickup_from}) async {
    await customerApi.bookDestination({
      'pickup_from': drop_off,
      'dropoff_to': pickup_from,
    });
  }

  void clearSettings() {
    isLoaded.value = false;
    hasBooking.value = false;
    onGoingRide.value = false;
    booking = Rxn<Booking>();
  }
}

class Booking {
  String? id;
  String? reference_code;
  String? status;
  String? order_id;
  String? accepted_by;
  String? created_at;
  String? updated_at;
  BookingDetails? bookingDetails;

  Booking({
    required this.id,
    required this.reference_code,
    required this.status,
    required this.order_id,
    required this.accepted_by,
    required this.created_at,
    required this.updated_at,
    required this.bookingDetails,
  });

  Booking.fromJson(Map<String, dynamic> json) {
    var data = json['booking'];

    id = data['id'].toString();
    reference_code = data['reference_code'].toString();
    status = data['status'].toString();
    order_id = data['order_id'].toString();
    accepted_by = data['accepted_by'].toString();
    created_at = data['created_at'].toString();
    updated_at = data['updated_at'].toString();
    bookingDetails = json['booking_detail'] != null
        ? BookingDetails.fromJson(json['booking_detail'])
        : null; // patut tarik data ni once order user dah kene accept
  }
}

class BookingDetails {
  String? id;
  String? reference_code;
  String? user_id;
  String? booking_id;
  String? driver_id;
  String? vehicle_id;
  String? user_wallet_id;
  String? driver_wallet_id;
  String? destination_id;
  String? pickup_from;
  String? pickup_time;
  String? dropoff_to;
  String? dropoff_time;
  bool? cancellable;
  String? reason;
  String? price;
  String? estimation_time;
  double? distance;
  String? created_at;
  String? updated_at;
  Pickup? pickup;
  DropOff? dropOff;
  Vehicle? vehicle;
  Driver? driver;

  BookingDetails({
    required this.id,
    required this.reference_code,
    required this.user_id,
    required this.booking_id,
    required this.driver_id,
    required this.vehicle_id,
    required this.user_wallet_id,
    required this.driver_wallet_id,
    required this.destination_id,
    required this.pickup_from,
    required this.pickup_time,
    required this.dropoff_to,
    required this.dropoff_time,
    required this.cancellable,
    required this.reason,
    required this.price,
    required this.estimation_time,
    required this.distance,
    required this.created_at,
    required this.updated_at,
    required this.pickup,
    required this.dropOff,
    required this.vehicle,
    required this.driver,
  });

  BookingDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    reference_code = json['reference_code'].toString();
    user_id = json['user_id'].toString();
    booking_id = json['booking_id'].toString();
    driver_id = json['driver_id'].toString();
    vehicle_id = json['vehicle_id'].toString();
    user_wallet_id = json['user_wallet_id'].toString();
    driver_wallet_id = json['driver_wallet_id'].toString();
    destination_id = json['destination_id'].toString();
    pickup_from = json['pickup_from'].toString();
    pickup_time = json['pickup_time'].toString();
    dropoff_to = json['dropoff_to'].toString();
    dropoff_time = json['dropoff_time'].toString();
    cancellable = json['cancellable'] == 1 ? true : false;
    reason = json['reason'].toString();
    price = json['price'].toString();
    estimation_time = json['estimation_time'].toString();
    distance = double.tryParse(json['distance'].toString());
    created_at = json['created_at'].toString();
    updated_at = json['updated_at'].toString();
    pickup = Pickup.fromJson(json['pickup_from']);
    dropOff = DropOff.fromJson(json['drop_off']);
    vehicle = Vehicle.fromJson(json['vehicle']);
    driver = Driver.fromJson(json['driver']);
  }
}

class Pickup {
  int? id;
  String? name;
  String? code;
  int? x;
  int? y;
  double? price;
  String? estimation_time;
  String? image_l;
  String? image_p;
  String? status;

  Pickup({
    required id,
    required name,
    required code,
    required x,
    required y,
    required price,
    required estimation_time,
    required image_l,
    required image_p,
    required status,
  });

  Pickup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    x = json['x'];
    y = json['y'];
    price = double.tryParse(json['price']);
    estimation_time = json['estimation_time'];
    status = json['status'];
    image_l = json['image_l'];
    image_p = json['image_p'];
  }
}

class DropOff {
  int? id;
  String? name;
  String? code;
  int? x;
  int? y;
  String? price;
  String? estimation_time;
  String? image_l;
  String? image_p;
  String? status;

  DropOff({
    required id,
    required name,
    required code,
    required x,
    required y,
    required price,
    required estimation_time,
    required image_l,
    required image_p,
    required status,
  });

  DropOff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    x = json['x'];
    y = json['y'];
    price = json['price'];
    estimation_time = json['estimation_time'];
    status = json['status'];
    image_l = json['image_l'];
    image_p = json['image_p'];
  }
}

class Vehicle {
  int? id;
  int? driver_id;
  String? plate_no;
  int? model_id;
  int? brand_id;
  String? color;
  String? mileage;
  String? status;
  VehicleModel? model;
  VehicleBrand? brand;

  Vehicle({
    required id,
    required driver_id,
    required plate_no,
    required model_id,
    required brand_id,
    required color,
    required mileage,
    required status,
    required model,
  });

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driver_id = json['driver_id'];
    plate_no = json['plate_no'];
    model_id = json['model_id'];
    brand_id = json['brand_id'];
    color = json['color'];
    mileage = json['mileage'];
    status = json['status'];
    model = VehicleModel.fromJson(json['model']);
    brand = VehicleBrand.fromJson(json['brand']);
  }
}

class VehicleModel {
  int? id;
  String? name;
  String? status;

  VehicleModel({
    required id,
    required name,
    required status,
  });

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }
}

class VehicleBrand {
  int? id;
  String? name;
  String? status;

  VehicleBrand({
    required id,
    required name,
    required status,
  });

  VehicleBrand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }
}

class Driver {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? driver_id;
  String? license_no;
  String? license_expiry;
  String? ratings;
  String? total_trips;
  String? status;
  bool? verified;
  String? mileage;

  Driver({
    required id,
    required name,
    required phone,
    required address,
    required driver_id,
    required license_no,
    required license_expiry,
    required ratings,
    required total_trips,
    required status,
    required verified,
    required mileage,
  });

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    driver_id = json['driver_id'];
    license_no = json['license_no'];
    license_expiry = json['license_expiry'];
    ratings = json['ratings'];
    total_trips = json['total_trips'];
    status = json['status'];
    verified = json['verified'] == 1 ? true : false;
    mileage = json['mileage'];
  }
}
