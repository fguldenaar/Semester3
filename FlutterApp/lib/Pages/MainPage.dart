import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rwzappp/Pages/DashboardPage.dart' as dashboard;
import 'package:rwzappp/Pages/ClientPage.dart' as clientpage;
import 'package:rwzappp/Models/Client.dart';

import '../Routers/Hub.dart';
import 'ClientPage.dart';
import 'DashboardPage.dart';

class MainPage extends StatefulWidget{
  MainPage({Key key, this.title, this.client}) : super(key:key);

  final Client client;
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  static DashboardTab dbTab;
  static ClientTab clientTab;

  List<Client> clientarray = [];

  static final hubCon = Hub.hubConnection;

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
//    hubCon.on("sendToAllWakeyWakey", onReceiveMessageWakeyWakey);
//    hubCon.on("sendToAll", onReceiveMessageAlive);
    //Hub.stopConnection();
    Hub.startConnection();
    print("Connection has been started");
  }

  @override
  void dispose() {
    controller.dispose();
    print("Disposed Main");
    Hub.stopConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        bottomNavigationBar: new Material(
            color: Colors.deepPurple,
            child: new TabBar(
                controller: controller,
                tabs: <Tab>[
                  new Tab(icon: Icon(Icons.home)),
                  new Tab(icon: Icon(Icons.group)),
                ]
            )
        ),
        body: new TabBarView(
          controller: controller,
          children: <Widget>[
            dbTab = dashboard.DashboardTab(),
            clientTab = clientpage.ClientTab()
            //clientpage.ClientTab()
          ],
        ),
      ),
    );
  }
}


