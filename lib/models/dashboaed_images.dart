class DashboardImage {
  String? name;
  String? path;

  DashboardImage({
    required this.name,
    required this.path,
  });

  factory DashboardImage.fromJson(Map<String, dynamic> json) {
    return DashboardImage(
      name: json['name'].toString(),
      path: json['path'].toString(),
    );
  }

  void findName() {
    print('Name: ${name}');
  }
}
