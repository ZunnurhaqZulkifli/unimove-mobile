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
