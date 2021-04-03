import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:no_roaming_test2/pages/sign_uo_page.dart';
import 'package:no_roaming_test2/widgets/my_button.dart';
import 'package:no_roaming_test2/widgets/textinput.dart';




import 'homepage.dart';
import 'dart:convert';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final BASE_URL = 'http://10.0.2.2:8000';
  final secStorage = FlutterSecureStorage();
  Map msg;

  LoginPage();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 45.0),
                  TextInput("Username", _usernameController),
                  SizedBox(height: 15.0),
                  TextInput("Password", _passwordController)
                  ,SizedBox(height: 15.0),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(26.0),
                  color: Color.fromRGBO(163, 72, 139, 1),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                    onPressed: () async {
                      var username = _usernameController.text;
                      var password = _passwordController.text;
                      var jwt = await attemptLogIn(username, password);
                      if (jwt != null) {
                        secStorage.write(key: "jwt", value: jwt);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage.fromBase64(jwt, username)));
                      } else {
                        displayDialog(context, "An Error Occurred",
                            "No account was found matching that username and password");
                      }
                    },
                    child: Text("LOGIN",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),

                  Container(
                      child: Row(
                        children: <Widget>[
                          Text('Does not have account?'),
                          FlatButton(
                            textColor: Color.fromRGBO(163, 72, 139, 1),
                            child: Text(
                              'Sign in',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )),

                ],
              ),
            ),
          ),
        ));
  }




  Future<String> attemptLogIn(String username, String password) async {
    var res = await http.post(Uri.parse("$BASE_URL/token"),
        body: {"username": username, "password": password});
    if (res.statusCode == 200) return res.body;
    return null;
  }

  Future<int> attemptSignUp(String username, String password) async {
    var res = await http.post(Uri.parse('$BASE_URL/users'),
        body: {"username": username, "password": password});
    return res.statusCode;
  }

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  /*void attempGmaillogin(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: "794598758183-7qcj9imd00ckd6cfnctsr91t0tp1fisv.apps.googleusercontent.com",

      scopes: [
        'email','profile',
        // you can add extras if you require
      ],
    );
    try{
      await _googleSignIn.signIn();
      displayDialog(context, '', "siker");
    }catch(error){
      displayDialog(context, '', error.toString());
    }

    _googleSignIn.signIn().then((GoogleSignInAccount acc) async {
      GoogleSignInAuthentication auth = await acc.authentication;
      print(acc.id);
      print(acc.email);
      print(acc.displayName);
      print(acc.photoUrl);

      acc.authentication.then((GoogleSignInAuthentication auth) async {
        print(auth.idToken);
        print(auth.accessToken);
      });
    });
  }*/

  /*void attempFbLogin() async {
    final facebookLogin = FacebookLogin();
    final facebookLoginResult = await facebookLogin.logInWithReadPermissions(['email']);

    print(facebookLoginResult.accessToken);
    print(facebookLoginResult.accessToken.token);
    print(facebookLoginResult.accessToken.expires);
    print(facebookLoginResult.accessToken.permissions);
    print(facebookLoginResult.accessToken.userId);
    print(facebookLoginResult.accessToken.isValid());

    print(facebookLoginResult.errorMessage);
    print(facebookLoginResult.status);

    final token = facebookLoginResult.accessToken.token;

    /// for profile details also use the below code
    final graphResponse = await http.get(Uri.parse(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token'));
    final profile = json.decode(graphResponse.body);
    print(profile);
    *//*
    from profile you will get the below params
    {
     "name": "Iiro Krankka",
     "first_name": "Iiro",
     "last_name": "Krankka",
     "email": "iiro.krankka\u0040gmail.com",
     "id": "<user id here>"
    }
   *//*
  }*/
}
