import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main(){
  test("Test statuscodes is 200", () async{
    var response = await http.get("https://rondjewelzijnapi.azurewebsites.net/api/Gebruikers");
    var is200 = response.statusCode;

    expect(is200, 200);
  });

  test("Test statuscodes is not 200", () async{
    var response = await http.get("https://rondjewelzijnapi.azurewebsites.net/api/Gebruikers/x");
    var not200 = response.statusCode;

    expect(not200, 400);
  });
}