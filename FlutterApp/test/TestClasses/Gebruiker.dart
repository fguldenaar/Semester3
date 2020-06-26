import 'RwzApi/ApiUser.dart';
import 'ReturnGebruiker.dart';
import 'package:http/http.dart' as http;

class Gebruiker implements ReturnGebruiker{

  @override
  Future<http.Response> pakGebruikers() async {

    http.Response data = await http.get("https://rondjewelzijnapi.azurewebsites.net/api/Gebruikers");

    return data;
  }

  Future<List<ApiUser>> getUsers() async{
    http.Response response = await http.get("https://rondjewelzijnapi.azurewebsites.net/api/Gebruikers");


  }

}
