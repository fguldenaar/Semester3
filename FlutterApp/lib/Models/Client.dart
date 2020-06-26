import 'package:flutter/material.dart';

class Client {

  final String iot;
  final String naam;
  final String email;
  final String telefoon;
  final String fotoUrl;
  final String wakeup;
  final int tijdRaam;
  String signaalAlive;
  String signaalWakeyWakey;
  Color signalColorAlive;
  Color signalColorWakeyWakey;

  Client(

      this.iot,
      this.naam,
      this.email,
      this.telefoon,
      this.fotoUrl,
      this.wakeup,
      this.tijdRaam,
      this.signaalAlive,
      this.signaalWakeyWakey,
      this.signalColorAlive,
      this.signalColorWakeyWakey);

}