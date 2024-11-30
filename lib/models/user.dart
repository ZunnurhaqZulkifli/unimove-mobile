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

class Wallet {
  String? user_id;
  double? balance;
  String? bank_id;
  String? card_number;
  String? card_expiry;
  String? card_ccv;
  String? card_type;
  String? created_at;
  String? updated_at;

  Wallet({
    required this.user_id,
    required this.balance,
    required this.bank_id,
    required this.card_number,
    required this.card_expiry,
    required this.card_ccv,
    required this.card_type,
    required this.created_at,
    required this.updated_at,
  });

  Wallet.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'].toString();
    balance = double.tryParse(json['balance']) ?? 0.00;
    bank_id = json['bank_id'].toString();
    card_number = json['card_number'].toString();
    card_expiry = json['card_expiry'].toString();
    card_ccv = json['card_ccv'].toString();
    card_type = json['card_type'].toString();
    created_at = json['created_at'].toString();
    updated_at = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'balance': balance,
      'bank_id': bank_id,
      'card_number': card_number,
      'card_expiry': card_expiry,
      'card_ccv': card_ccv,
      'card_type': card_type,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }
}
