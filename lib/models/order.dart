
class Order {
  int? id;
  String? orderable_type;
  int? orderable_id;
  String? pickup_from;
  String? dropoff_to;
  String? price;
  String? distance;
  String? estimation_time;
  String? status;
  String? created_at;

  Order({
    required this.id,
    required this.orderable_type,
    required this.orderable_id,
    required this.pickup_from,
    required this.dropoff_to,
    required this.price,
    required this.distance,
    required this.estimation_time,
    required this.status,
    required this.created_at,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderable_type: json['orderable_type'].toString(),
      orderable_id: json['orderable_id'],
      pickup_from: json['pickup_from'].toString(),
      dropoff_to: json['dropoff_to'].toString(),
      price: json['price'].toString(),
      distance: json['distance'].toString(),
      estimation_time: json['estimation_time'].toString(),
      status: json['status'].toString(),
      created_at: json['created_at'].toString(),
    );
  }
}
