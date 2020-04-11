import 'package:flutter/material.dart';
import 'package:rwzapp/dasheboard.dart';
import 'package:rwzapp/login.dart';

import 'dasheboard.dart';
import 'login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget{
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp>{

  //Variables
  Widget _screen;
  login _login;
  dashboard _settings;
  bool _authenticated;

  //State of the app
  _MyAppState(){
    _login = new login(onSubmit: (){onSubmit();});
    _settings = new dashboard();
    _screen = _login;
    _authenticated = false;
  }

  //Methods
  void onSubmit(){
    print('Login with:' + _login.username + ' ' + _login.password);
    if(_login.username == 'user' && _login.password == 'password'){
      _setAuthenticated(true);

    }
  }

  void _goHome(){
    print('go home');
    if(_authenticated == true){
      _screen = _settings;
    }
    else{
      _screen = _login;
    }


  }

  void _logout(){
    print('log out');
    _setAuthenticated(false);
  }

  void _setAuthenticated(bool auth){
    setState(() {
      if(auth == true){
        _screen = _settings;
        _title = 'Rondje Welzijn';
      }
      else{
        _screen = _login;
        _title = 'Rondje Welzijn';
      }
    });
  }

  //AppBar
  String _title = 'Rondje welzijn';
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Appbar',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(_title),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.home), onPressed: (){_goHome();}),
            new IconButton(icon: new Icon(Icons.exit_to_app), onPressed: (){_logout();}),
          ],
        ),
        body: _screen,
      ),
    );
  }
}