import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Pages/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static const PrimaryColor = const Color(0xFF3f51b5);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rondje Welzijn',
      theme: ThemeData(
          primaryColor: Colors.deepPurple,
      ),
      home: LoginScreen(),
    );
  }
}
