import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rwzappp/Routers/router.dart' as router;

import '../Routers/Hub.dart';

class Signal extends StatelessWidget{

  Widget _screen;
  String _title = "Rondje Welzijn";

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SignalR',
        onGenerateRoute: router.generateRouter,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: _screen,
      )
    );
  }
}

class SignalList extends StatefulWidget {
  SignalList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignalListState createState() => new _SignalListState();
}

class _SignalListState extends State<SignalList> {

  String _signal = "";
  String _title = "Rondje Welzijn";
  final hubCon = Hub.hubConnection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pop(context);
      }),
      appBar: AppBar(
        title: Text(_title, style: TextStyle(color: Colors.white)),
      ),
      body: new Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/splash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(_signal),
            ],
          )
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    hubCon.on("sendToall", onReceiveMessageAlive);
    hubCon.on("sendToallWakeyWakey", onReceiveMessageWakeyWakey);
    Hub.startConnection();

  }

  void onReceiveMessageAlive(List<Object> result) {
    setState(() {
      _signal = "IoT:${result[0]} '\n' Status:${result[1]}";
    });
  }

  void onReceiveMessageWakeyWakey(List<Object> result) {
    setState(() {
      _signal = "IoT:${result[0]} '\n'  Status:${result[1]}";
    });
  }
}