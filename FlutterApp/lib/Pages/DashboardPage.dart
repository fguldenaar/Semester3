import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:rwzappp/Models/IotStates.dart';
import 'package:http/http.dart' as http;
import '../Routers/Hub.dart';
import 'package:rwzappp/Models/Client.dart';


class DashboardTab extends StatefulWidget {
  DashboardTab({Key key, this.title}) : super(key: key){

  }

  final String title;
  _DashboardTab _dashboardTab;

  @override
  _DashboardTab createState() => new _DashboardTab();

  void Connect(List<Object> results){
    _dashboardTab.onReceiveMessageWakeyWakey(results);

  }
}

class _DashboardTab extends State<DashboardTab>{
  String _title = "Dashboard";
  int _numClients = 6;
  _DashboardTab _dashboardTab;
  static final hubCon = Hub.hubConnection;
  List<Client> clientarray = [];

  @override
  void dispose() {
    print("Disposed Dashboard");
    super.dispose();
  }

  @override
  void initState() {
    _dashboardTab = new _DashboardTab();
    hubCon.on("sendToAllWakeyWakey", onReceiveMessageWakeyWakey);
    hubCon.on("sendToAll", onReceiveMessageAlive);
    Hub.startConnection();

    super.initState();
  }

  List<IotStates> _iotStates = new List();

  //Signalen voor WakeyWakey: Pending, Monitoring, Opgestaan en Alarm
  void onReceiveMessageWakeyWakey(List<Object> result) {
    try{
      _countClients(_numClients);
      setState(()
      {
        if (_numClients > 0) {
          for (int i =0; i<_numClients;i++) {
            for (IotStates state in _iotStates){
              if (state.getState() == result[1]){
                state.increaseCount();
              }
            }
          }
        }
      });

    } catch  (e){
      print(e);
    }
  }

  String _signaal = "";

  void onReceiveMessageAlive(List<Object> result) {
    //print();
    if (clientarray.length > 0) {
      for (Client iot in clientarray) {
        if (iot.iot == result[0]) {
          setState(() {
            iot.signaalAlive = result[1];
            if (result[1] == "Offline") {
              iot.signalColorAlive = Colors.red;
            } else if (result[1] == "Alive") {
              iot.signalColorAlive = Colors.green;
            }
            _signaal = "IoT: ${result[0]} zegt: ${result[1]}";
          });
        }
      }
    }
  }

  void _listData(){
    _iotStates.add(new IotStates("Alarm", 0));
    _iotStates.add(new IotStates("Opgestaan", 0));
    _iotStates.add(new IotStates("Monitoring", 0));
    _iotStates.add(new IotStates("Pending", 0));
  }

  Future<int> _countClients(int numClients) async {
    if (numClients == 0) {
      var data = await http
          .get("https://rondjewelzijnapi.azurewebsites.net/api/Clienten");

      var jsonData = json.decode(data.body);


      for (var clients in jsonData) {
        numClients++;
      }
    }
    return numClients;
  }

  Map _mapData(List dataList){
    print (_iotStates.length);
    if (_iotStates.length == 0) {
      _listData();
    }
    Map<String, double> dataMap = new Map();
    for (IotStates data in dataList){
      dataMap.putIfAbsent(data.getState(), () => data.getCount());
    }
    return dataMap;
  }

  Widget _buildDashboardChart (Map<String, double> dataMap, BuildContext buildContext){
    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32.0,
      chartRadius: MediaQuery.of(buildContext).size.width/2.7,
      showChartValuesInPercentage:  true,
      showChartValues: true,
      showChartValuesOutside:  false,
      chartValueBackgroundColor:  Colors.grey[200],
      chartValueStyle: defaultChartValueStyle.copyWith(
          color: Colors.blueGrey[900].withOpacity(0.9)
      ),
      chartType: ChartType.disc,
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: new FittedBox(
                        child: Material(
                          color: Colors.white,
                          elevation: 14.0,
                          borderRadius: BorderRadius.circular(24.0),
                          shadowColor: Color(0x802196F3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                ),
                              ),
                              Container(
                                  child: _buildDashboardChart(_mapData(_iotStates), context)
                              ),
                              Container(
                                width: 200,
                                height: 150,
                                child: ClipRRect(
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          new Text("Welkom verzorger!!",
                                            style: TextStyle(fontWeight: FontWeight.bold),),
                                          new Text("Hierboven is een globale weergave gegeven van de status van uw cliënten. Om meer informatie te verkrijgen klik op het cliënten tabblad."),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}