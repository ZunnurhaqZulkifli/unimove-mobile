import 'package:flutter/material.dart';

// change to get x
class User extends ChangeNotifier {
  User({
    required this.name,
    required this.email,
    required this.password,
  });

  String name;
  String email;
  String password;

  void updateProfile({
    required String name,
    required String email,
    required String password,
  }) {
    this.name = name;
    this.email = email;
    notifyListeners();
  }
}
