import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:no_roaming_test2/pages/loginpage.dart';



final secStorage = FlutterSecureStorage();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<String> get jwtOrEmpty async {
    var jwt = await secStorage.read(key: "jwt");
    if(jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'No Roaming',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: LoginPage()
    );
  }
}