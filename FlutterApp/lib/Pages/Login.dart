import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'package:rwzappp/Pages/MainPage.dart';

class EmailValidator {
  EmailValidator();
  String validate(String value) {
    return value.isEmpty ? 'Email cannot be empty' : null;
  }
}

class PasswordValidator {
  PasswordValidator();
  String validate(String value) {
    return value.isEmpty ? 'Password cannot be empty' : null;
  }
}

var users = {};

// het asynchroon vullen van  het mapje 'users' met emails en wachtwoorden van gebruikers.
Future _getUsers() async {
  var data = await http.get("https://rondjewelzijnapi.azurewebsites.net/api/Gebruikers");


  var jsonData = json.decode(data.body);

  if (data.statusCode.toString() == "200") {
    print("Login statuscode is " + data.statusCode.toString());
  } else if(data.statusCode.toString() != "200"){
    print("Login statuscode is not " + data.statusCode.toString());
  } else {throw Exception ("Login Failed to connect");}


  for (var user in jsonData) {
    users.addAll({user["email"]: user["wachtwoord"]});
  }
}

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Gebruikersnaam bestaat niet';
      }
      if (users[data.name] != data.password) {
        return 'Het wachtwoord komt niet overeen';
      }
      return null;
    });
  }

  Future<String> _registerUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (users[data.name] != data.password) {
        return 'Aanvraag verstuurd';
      }
      return null;
    });
  }

  Future<String> _passUser() {
    return Future.delayed(loginTime).then((_) {
      return "Verzonden";
    });
  }

  @override
  Widget build(BuildContext context) {
    _getUsers();
    return SafeArea(
      child: Container(
        color: Colors.blueGrey,
        padding: new EdgeInsets.only(top: 25.0),
        //.symmetric(horizontal: 0.0, vertical: 40.0),
        child: FlutterLogin(
          title: 'Rondje Welzijn',
          logo: 'assets/images/logoRW.png',
          onLogin: _authUser,
          onSignup: _registerUser,
          onSubmitAnimationCompleted: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MainPage(title: 'Rondje Welzijn app'),
            ));
          },
          onRecoverPassword: (_) => Future(_passUser),
          messages: LoginMessages(
            recoverPasswordIntro: 'Reset jouw wachtwoord',
            usernameHint: 'Gebruikersnaam',
            passwordHint: 'Wachtwoord',
            confirmPasswordHint: 'Bevestig',
            loginButton: 'LOG IN',
            signupButton: 'REGISTER',
            forgotPasswordButton: 'Wachtwoord vergeten?',
            recoverPasswordButton: 'HELP',
            goBackButton: 'Terug',
            confirmPasswordError: 'Wachtwoorden matchen niet!',
            recoverPasswordDescription: 'Voer hier jouw gebruikersnaam in.',
            recoverPasswordSuccess: 'Wachtwoord reset verzonden',
          ),
          emailValidator: (value) {
            if (!value.contains('@')) {
              return "Gebruikersnaam moet een '@' bevatten";
            }
            return null;
          },
          passwordValidator: (value) {
            if (value.isEmpty) {
              return 'Wachtwoord is leeg';
            }
            return null;
          },
        ),
      ),
    );
  }
}
