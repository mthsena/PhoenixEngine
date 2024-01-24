import '../data/models/network/client_connection/client_connection.dart';
import '../network/data_handler/data_handler.dart';
import 'memory/memory.dart';

class ClientHandler {
  final ClientConnectionModel client;

  ClientHandler({required this.client});

  void handleClient() {
    DataHandler dataHandler = DataHandler();

    client.socket.listen((data) {
      print(data);
      dataHandler.handleData(client: client, data: data);
    }, onError: (error) {
      print('Ocorreu um erro: $error');
    }, onDone: () {
      print('Conexão com o jogador ${client.id} fechada');
      ServerMemory().clientConnections.remove(index: client.id);
      client.socket.close();
    });
  }
}
