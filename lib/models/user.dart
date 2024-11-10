class User {
  String? id;
  String? name;
  String? type;
  String? typeable_id;
  String? username;
  String? email;
  String? tac;
  Profile? profile;

  User({
    required this.id,
    required this.name,
    required this.type,
    required this.typeable_id,
    required this.username,
    required this.email,
    required this.tac,
    required this.profile,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'] ?? '';
    username = json['username'] ?? '';
    type = json['typeable_type'] ?? '';
    typeable_id = json['typeable_id'].toString();
    email = json['email'] ?? '';
    tac = json['tac'].toString();
    profile = json['profile'] != null
        ? Profile.fromJson(
            json['profile'],
            type: json['typeable_type'],
          )
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      // 'name': name,
      // 'username': username,
      // 'email': email,
    };
  }
}

class Profile {
  String? type;
  String? id;
  String? id_number;
  String? student_id;
  String? avatar;
  String? address;
  String? name;
  String? phone;
  String? status;
  bool? verified;
  String? created_at;

  Profile({
    required this.type,
    required this.id,
    required this.id_number,
    required this.student_id,
    required this.avatar,
    required this.address,
    required this.name,
    required this.phone,
    required this.status,
    required this.verified,
    required this.created_at,
  });

  Profile.fromJson(Map<String, dynamic> json, {String type = ''}) {
    type = type;
    id = json['id'].toString();
    id_number = json['id_number'] ?? '';
    student_id = json['student_id'].toString();
    avatar = json['avatar'] ?? '';
    address = json['address'] ?? '';
    name = json['name'] ?? '';
    phone = json['phone'].toString();
    status = json['status'] ?? '';
    verified = json['verified'] == 0 ? false : true;
    created_at = json['created_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      // 'name': name,
      // 'username': username,
      // 'email': email,
    };
  }
}
