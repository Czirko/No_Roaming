import 'package:flutter/material.dart';

class User {
  final int userId;
  final String username;
  final String passwordhash;
  final String fullname;
  final String email;

  User(
      {@required this.userId,
        @required this.username,
        @required this.passwordhash,
        @required this.fullname,
        @required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      username: json['username'],
      passwordhash: json['password_hash'],
      fullname: json['fullname'],
      email: json['email'],
    );
  }
}
