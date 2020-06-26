import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';
import 'package:http/http.dart' as http;
import 'package:rwzappp/Models/Client.dart';
import 'package:rwzappp/Pages/DetailPage.dart';
import 'DetailPage.dart';
import '../Routers/Hub.dart';

class ClientTab extends StatefulWidget{
  ClientTab({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ClientTab createState() => new _ClientTab();

}

class _ClientTab extends State<ClientTab> {
  List<Client> clientarray = [];
  static final hubCon = Hub.hubConnection;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    hubCon.on("sendToAllWakeyWakey", onReceiveMessageWakeyWakey);
    hubCon.on("sendToAll", onReceiveMessageAlive);
    Hub.startConnection();
    super.initState();

  }

  //Signalen voor WakeyWakey: Pending, Monitoring, Opgestaan en Alarm
  void onReceiveMessageWakeyWakey(List<Object> result) {
    try {
      if (clientarray.length > 0) {
        for (Client iot in clientarray) {
          if (iot.iot == result[0]) {
            setState(() {
              print("WakeyWakey Bericht wordt ontvangen");
              iot.signaalWakeyWakey = result[1];
              if (result[1] == "Alarm") {
                iot.signalColorWakeyWakey = Colors.red;
              } else if (result[1] == "Opgestaan") {
                iot.signalColorWakeyWakey = Colors.green;
              } else if (result[1] == "Monitoring") {
                iot.signalColorWakeyWakey = Colors.lightBlue;
              } else if (result[1] == "Pending") {
                iot.signalColorWakeyWakey = Colors.yellow;
              }
            });
          }
        }
      }
    } catch (e){
      print(e);
    }
  }

  String _signaal;

  void onReceiveMessageAlive(List<Object> result) {
    if (clientarray.length > 0) {
      for (Client iot in clientarray) {
        if (iot.iot == result[0]) {
          setState(() {
            print("Alive Bericht wordt ontvangen");
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


  Future<List<Client>> _getClients(String url) async {
    if (clientarray.length == 0) {
      var data = await http
          .get(url);

      var jsonData = json.decode(data.body);

      if (data.statusCode.toString() == "200") {
        print("Clientpage statuscode is " + data.statusCode.toString());
      } else if(data.statusCode.toString() != "200"){
        print("Clientpage statuscode is not " + data.statusCode.toString());
      } else {throw Exception ("Clientpage Failed to connect");}

      for (var clients in jsonData) {
        Client client = Client(
            clients["iot"],
            clients["naam"],
            clients["email"],
            clients["telefoon"],
            clients["fotoUrl"],
            clients["wakeup"],
            clients["tijdRaam"],
            "pending",
            "pending",
            Colors.blue.shade400,
            Colors.blue.shade400);
        clientarray.add(client);
      }
    }
    return clientarray;
  }

  IconData _getIcon(String status){
    switch (status) {
      case "Alarm":
        {
          return Icons.thumb_down;
        }
        break;
      case "Monitoring":
        {
          return Icons.thumbs_up_down;
        }
        break;
      case "Opgestaan":
        {
          return Icons.thumb_up;
        }
        break;
      case "Pending":
        {
          return Icons.brightness_2;
        }
        break;
      default:
        {
          return Icons.hourglass_empty;
        }
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        appBar: AppBar(title: Text('Clienten')),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/splash.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder(
            future: _getClients("https://rondjewelzijnapi.azurewebsites.net/api/Clienten"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(child: Center(child: Text("Momentje...")));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Padding(
                      padding: new EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: new Card(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(16.0),
                        ),
                        child: new Column(
                          children: <Widget>[
                            new ClipRRect(
                              child: new ListTile(
                                leading: GFAvatar(
                                  backgroundImage:
                                      NetworkImage(snapshot.data[index].fotoUrl),
                                  shape: GFAvatarShape.standard,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                title: Row(
                                  children: <Widget>[
                                    Icon((() {
                                      return _getIcon(snapshot.data[index].signaalWakeyWakey);
                                    })(),
                                        color: snapshot
                                            .data[index].signalColorWakeyWakey),
                                  ],
                                ),
                                subtitle: Text(snapshot.data[index].naam),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              Detail(snapshot.data[index])));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
