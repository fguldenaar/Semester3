import 'dart:convert';
//import 'dart:html';

import 'package:flutter/material.dart';
//import 'package:rwzapp/dashboard.dart';
import 'package:http/http.dart' as http;

class ThisDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Dashboard',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ThisDashboard(

      ),
    );
  }
}


class dashboard extends StatefulWidget{
  dashboard({Key key, this.title}) : super(key:key);

  final String title;

  @override
  _ThisDashboardState createState() => new _ThisDashboardState();

}

class _ThisDashboardState extends State<dashboard> {


  Future<List<Client>> _getClienten() async {
    var data = await http.get("https://rondjewelzijnapi.azurewebsites.net/api/Clienten");
    var jsonData = json.decode(data.body);

    List<Client> clienten = [];

    for(var cl in jsonData){
      Client client = Client(cl["index"], cl["naam"]);
      clienten.add(client);
    }
    print(clienten.length);
    return clienten;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Clienten'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getClienten(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            print(snapshot.data);
            if(snapshot.data == null){
              return Container(
                  child: Center(
                      child: Text("Momentje...")
                  )
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(

                    title: Text(snapshot.data[index].naam),
                    onTap: (){

                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                      );

                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget{
  final Client client;

  DetailPage(this.client);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(client.naam),
      ),
    );
  }
}

class Client{
 final int index;
 final String naam;
 //final String fotoUrl;

 Client(this.index, this.naam);
}


