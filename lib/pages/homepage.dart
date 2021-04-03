import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:no_roaming_test2/model/token.dart';
import 'package:no_roaming_test2/model/user.dart';


class HomePage extends StatelessWidget {
  HomePage(this.jwt, this.payload, this.USERNAME);

  final SERVER_URL = 'http://10.0.2.2:8000';
  final secStorage = FlutterSecureStorage();

  factory HomePage.fromBase64(String jwt, String username) => HomePage(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))),
      username);
  String USERNAME;
  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Hello " + payload['username'])),
    body: Center(
      child: FutureBuilder<User>(

          future: fechUser(),
          builder: (context, snapshot) => snapshot.hasData
              ? Container(
                child: Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Hello' ),
                      Text(snapshot.data.fullname),
                      Text('e-mail:'+snapshot.data.email),

                    ],
                  ),
                )
          ),
              )

              : snapshot.hasError
              ? Text("An error occurred--12")
              : CircularProgressIndicator()),
    ),
  );

  Future<User> fechUser() async {
    final access_token = Token.fromJson(jsonDecode(jwt)).access_token;

    var response =await http.get(Uri.parse('$SERVER_URL/users/me'),headers : {
      'Authorization': 'Bearer $access_token'
    });

    log(response.toString());
    if (response.statusCode == 200) {
      log('code 200');
      return User.fromJson(jsonDecode(response.body));
    } else {
      log('response failed');
      throw Exception('Failed to load user');
    }
  }
}



