import 'package:flutter/material.dart';
import 'package:rwzappp/Models/Client.dart';
import 'package:rwzappp/Pages/DetailPage.dart';
import 'package:rwzappp/Models/SignalList.dart';
import 'package:rwzappp/Routers/routing_constants.dart';

Route<dynamic> generateRouter(RouteSettings settings){
  switch (settings.name){
    case DetailPageRoute:
      Client client;
      return MaterialPageRoute(builder: (context) => Detail(client));
    case SignalRoute:
      return MaterialPageRoute(builder: (context) => SignalList());
    default:
      Client client;
      return MaterialPageRoute(builder: (context) => Detail(client));
  }
}