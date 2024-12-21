import 'package:unimove/models/profile.dart';
import 'package:unimove/models/wallet.dart';

class User {
  String? id;
  String? name;
  String? type;
  String? typeable_id;
  String? username;
  String? email;
  String? tac;
  Profile? profile;
  Wallet? wallet;
  bool verified = false;

  User({
    required this.id,
    required this.name,
    required this.type,
    required this.typeable_id,
    required this.username,
    required this.email,
    required this.tac,
    required this.profile,
    required this.wallet,
    required this.verified,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'] ?? '';
    username = json['username'] ?? '';
    type = json['typeable_type'] ?? '';
    typeable_id = json['typeable_id'].toString();
    email = json['email'] ?? '';
    tac = json['tac'].toString();
    verified = json['profile'] != null ? true : false;
    profile = json['profile'] != null
        ? Profile.fromJson(
            json['profile'],
            type: json['typeable_type'],
          )
        : null;
    wallet = json['wallet'] != null
        ? Wallet.fromJson(
            json['wallet'],
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
