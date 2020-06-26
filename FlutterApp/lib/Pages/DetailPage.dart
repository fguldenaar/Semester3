import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/shape/gf_avatar_shape.dart';
import 'package:intl/intl.dart';
import 'package:rwzappp/Models/Client.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Routers/Hub.dart';

class Detail extends StatefulWidget {
  final Client client;

  Detail(this.client);

  DateFormat dateFormat = DateFormat("HH:mm");

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String _signaal = "";

  // SignalR Hub connectie maken
  final hubCon = Hub.hubConnection;

  @override
  void initState() {
    super.initState();
    hubCon.on("sendToall", onReceiveMessageAlive);
    hubCon.on("sendToallWakeyWakey", onReceiveMessageWakeyWakey);
    //Hub.startConnection();
  }

  // wanneer de hub (SignalR) een message verstuurd, dan wordt dat hier opgevangen.
  //SignalR hub integratietesten
  void onReceiveMessageAlive(List<Object> result) {
    if (widget.client.iot == result[0]) {
      setState(() {
        print("WakeyWakey Bericht wordt ontvangen");
        print("Deze client is " + result[1].toString());
        widget.client.signaalAlive = result[1];
        if (result[1] == "Offline") {
          widget.client.signalColorAlive = Colors.red;
        } else if (result[1] == "Alive") {
          widget.client.signalColorAlive = Colors.green;
        }
      });
    }
  }

  void onReceiveMessageWakeyWakey(List<Object> result) {
    if (widget.client.iot == result[0]) {
      setState(() {
        print("Alive Bericht wordt ontvangen");
        print("Deze client is " + result[1].toString());
        widget.client.signaalWakeyWakey = result[1];
        if (result[1] == "Alarm") {
          widget.client.signalColorWakeyWakey = Colors.red;
        } else if (result[1] == "Opgestaan") {
          widget.client.signalColorWakeyWakey = Colors.green;
        } else if (result[1] == "Monitoring") {
          widget.client.signalColorWakeyWakey = Colors.lightBlue;
        } else if (result[1] == "Pending") {
          widget.client.signalColorWakeyWakey = Colors.yellow;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime Opstaantijd = DateTime.parse(widget.client.wakeup);
    var OpstaanVoor =
    Opstaantijd.add(new Duration(hours: widget.client.tijdRaam));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.client.naam),
        ),
        body: SingleChildScrollView(
          child: Card(
            margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(""),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(widget.client.naam),
                    subtitle: Text(widget.client.telefoon),
                  ),
                  ListTile(
                    title: Row(children: <Widget>[
                      Icon(
                        (() {
                          if (widget.client.signaalWakeyWakey == "Alarm") {
                            return Icons.thumb_down;
                          } else if (widget.client.signaalWakeyWakey ==
                              "Monitoring") {
                            return Icons.thumbs_up_down;
                          } else if (widget.client.signaalWakeyWakey == "Opgestaan") {
                            return Icons.thumb_up;
                          } else if (widget.client.signaalWakeyWakey == "Pending") {
                            return Icons.brightness_2;
                          }
                          return Icons.hourglass_empty;
                        })(),
                        color: widget.client.signalColorWakeyWakey,
                        size: 75.0,
                      ),
                    ]),
                  ),
                  Center(
                      child: GFAvatar(
                        backgroundImage: NetworkImage(widget.client.fotoUrl),
                        radius: 150.0,
                        size: GFSize.LARGE,
                        shape: GFAvatarShape.standard,
                      )),
                  ButtonBar(
                    children: <Widget>[
                      RaisedButton.icon(
                        icon: Icon(Icons.call),
                        textColor: Colors.white,
                        color: Colors.orange,
                        hoverColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            side: BorderSide(width: 3.0, color: Colors.amber)),
                        label: Text('Bel ' + widget.client.naam),
                        onPressed: () => launch("tel://" + widget.client.telefoon),
                      ),
                    ],
                  ),
                  ListTile(
                    contentPadding: new EdgeInsets.fromLTRB(10, 10, 10, 20),
                    title: Text(
                        "Opstaantijd: " +
                        widget.dateFormat.format(Opstaantijd).toString() +
                        " uur"),
                    subtitle: Text(widget.client.naam +
                        " geeft zichzelf " +
                        widget.client.tijdRaam.toString() +
                        " uur om op te staan. "
                            "Uiterlijk vandaag om " +
                        widget.dateFormat.format(OpstaanVoor).toString() +
                        " uur moet " +
                        widget.client.naam +
                        " opgestaan zijn."),
                    trailing: Icon((() {
                      if (widget.client.signaalAlive == "Offline") {
                        return Icons.sync_disabled;
                      } else if (widget.client.signaalAlive == "pending") {
                        return Icons.sync_problem;
                      }
                      return Icons.sync;
                    })(), color: widget.client.signalColorAlive),
                    )
                  ],
                ),
              ),
            ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Text(
            " " + '$_signaal',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        ),
    );
  }
}


