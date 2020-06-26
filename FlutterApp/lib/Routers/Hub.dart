import 'package:signalr_client/hub_connection_builder.dart';

class Hub {

  static final hubConnection = HubConnectionBuilder()
      .withUrl("https://rondjewelzijnapi.azurewebsites.net/signal")
      .build();

  static void startConnection() async {
    await hubConnection.start();
    print("HubConnection made connection");
  }

  static void stopConnection() async {
    await hubConnection.stop();
  }
}




