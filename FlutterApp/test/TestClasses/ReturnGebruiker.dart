import 'dart:convert';
import 'package:rwzappp/Models/Client.dart';
import 'package:http/http.dart' as http;

import 'RwzApi/ApiUser.dart';

abstract class ReturnGebruiker{

  Future<http.Response> pakGebruikers();

  Future<List<ApiUser>> getUsers() {}

}