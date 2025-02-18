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
    print(json);
    id = json['id'].toString();
    reference_code = json['reference_code'].toString();
    status = json['status'].toString();
    order_id = json['order_id'].toString();
    accepted_by = json['accepted_by'].toString();
    created_at = json['created_at'].toString();
    updated_at = json['updated_at'].toString();
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
  String? distance;
  String? created_at;
  String? updated_at;

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
    distance = json['distance'].toString();
    created_at = json['created_at'].toString();
    updated_at = json['updated_at'].toString();
  }
}
