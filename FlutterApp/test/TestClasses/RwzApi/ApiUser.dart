import 'dart:convert';
import 'package:rwzappp/Models/Client.dart';
import 'package:http/http.dart' as http;
class ApiUser {


  Future<List<ApiUser>> getUsers() async{
    var response = await http.get("https://rondjewelzijnapi.azurewebsites.net/api/Gebruikers");
    var list = jsonDecode(response.body) as List;
  }

  int id;
  String naam;
  String email;
  String telefoon;
  String fotoUrl;
  String gebruikersnaam;
  String wachtwoord;
  Null token;
  Null schemas;
  Null verzorgers;

  ApiUser(
      {this.id,
        this.naam,
        this.email,
        this.telefoon,
        this.fotoUrl,
        this.gebruikersnaam,
        this.wachtwoord,
        this.token,
        this.schemas,
        this.verzorgers});

  ApiUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    naam = json['naam'];
    email = json['email'];
    telefoon = json['telefoon'];
    fotoUrl = json['fotoUrl'];
    gebruikersnaam = json['gebruikersnaam'];
    wachtwoord = json['wachtwoord'];
    token = json['token'];
    schemas = json['schemas'];
    verzorgers = json['verzorgers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['naam'] = this.naam;
    data['email'] = this.email;
    data['telefoon'] = this.telefoon;
    data['fotoUrl'] = this.fotoUrl;
    data['gebruikersnaam'] = this.gebruikersnaam;
    data['wachtwoord'] = this.wachtwoord;
    data['token'] = this.token;
    data['schemas'] = this.schemas;
    data['verzorgers'] = this.verzorgers;
    return data;
  }
}

