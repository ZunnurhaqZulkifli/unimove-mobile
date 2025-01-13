class Destination {
  String? id;
  String? name;
  String? code;
  String? address;
  String? price;
  String? estimation_time;
  String? status;
  String? image_l;
  String? image_p;

  Destination({
    required this.id,
    required this.name,
    required this.code,
    required this.address,
    required this.price,
    required this.estimation_time,
    required this.status,
    required this.image_l,
    required this.image_p,
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
      image_l: json['image_l'].toString(),
      image_p: json['image_p'].toString(),
    );
  }

  void findName() {
    print('Name: ${name}');
  }
}
