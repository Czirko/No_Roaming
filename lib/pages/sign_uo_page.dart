import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:no_roaming_test2/widgets/textinput.dart';

import 'loginpage.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final BASE_URL = 'http://10.0.2.2:8000';
  final secStorage = FlutterSecureStorage();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );



  Future<String> attemptSignUp(BuildContext context, String username,
      String password, String fullname, String email) async {
    var res = await http.post(Uri.parse('$BASE_URL/users'),
        headers: <String,String>{
          'Content-Type': 'application/json'
        },

        body:jsonEncode({"username": "$username", "password_hash": "$password","fullname": "$fullname", "email": "$email"}),);
    if (res.statusCode == 200) {
      return username;
    } else {
      displayDialog(context, 'Hiba', res.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
                height: 45.0,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextInput('Username', _usernameController),
              SizedBox(height: 15.0),
              TextInput('Password', _passwordController),
              SizedBox(height: 15.0),
              TextInput('Full name', _fullNameController),
              SizedBox(height: 15.0),
              TextInput('E-mail', _emailController),
              SizedBox(height: 15.0),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(26.0),
                color: Color.fromRGBO(163, 72, 139, 1),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                  onPressed: ()async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    var fullname = _fullNameController.text;
                    var email = _emailController.text;
                    var name = await attemptSignUp(
                        context, username, password, fullname, email);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text("Sign up",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),


            ],
          ),
        ));
  }


}
