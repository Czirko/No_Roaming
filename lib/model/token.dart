import 'package:flutter/material.dart';

class Token {
  final String access_token;
  final String type;

  Token({@required this.access_token, @required this.type});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      access_token: json['access_token'],
      type: json['token_type'],
    );
  }
}
