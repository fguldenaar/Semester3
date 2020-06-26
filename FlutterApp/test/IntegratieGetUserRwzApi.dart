import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'TestClasses/Gebruiker.dart';
import 'TestClasses/PublicApi/MockUser.dart';
import 'TestClasses/ReturnGebruiker.dart';
import 'TestClasses/RwzApi/ApiUser.dart';


void main() {
  test("get Length API UserList", () async {

    //Arrange
    ReturnGebruiker returnData = Gebruiker();

    //Act
    http.Response response = await returnData.pakGebruikers();
    var list = jsonDecode(response.body) as List;

    //Assert
    expect(list.length, 7);

  });

  test("get username from API", () async {
    //Arrange
    MyApiUser apiUser = MyApiUser();

    //Act
    var users = await apiUser.getUsers();

    //Assert
    expect(users.first.name, "Leanne Graham");

  });

}

class UserApi{
  Future<List<ApiUser>> getGebruikers() async{
    var respone = await http.get("https://rondjewelzijnapi.azurewebsites.net/api/Gebruikers");
    var list = jsonDecode(respone.body) as List;

  }
}

class MyApiUser {
  Future<List<MockUser>>getUsers() async{
    var response = await http.get("https://jsonplaceholder.typicode.com/users");
    var list = jsonDecode(response.body) as List;
    return list.map((item) => MockUser.fromJson(item)).toList();


  }
}


