import 'dart:convert';
import 'package:flutter/material.dart';
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


  Future<List<User>> _getUsers() async {
    var data = await http.get("http://localhost:8080/api/v1/user");
    var jsonData = json.decode(data.body);

    List<User> users = [];

    for(var cl in jsonData){
      User user = User(cl["index"], cl["username"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Users'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            print(snapshot.data);
            if(snapshot.data == null){
              return Container(
                  child: Center(
                      child: Text("Loading...")
                  )
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(

                    title: Text(snapshot.data[index].username),
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
  final User client;

  DetailPage(this.client);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(client.username),
      ),
    );
  }
}

class User{
 final int index;
 final String username;

 User(this.index, this.username);
}


