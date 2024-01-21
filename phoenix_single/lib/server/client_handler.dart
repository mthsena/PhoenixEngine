import '../data/models/network/client_connection/client_connection.dart';
import '../network/data_handler/data_handler.dart';
import 'temp_memory/temp_memory.dart';

class ClientHandler {
  final ClientConnectionModel client;

  ClientHandler({required this.client});

  void handleClient() {
    print('Recebendo conexão do jogador ${client.id}: ${client.socket.remoteAddress}:${client.socket.remotePort}');

    DataHandler dataHandler = DataHandler();

    client.socket.listen((data) {
      dataHandler.handleData(client: client, data: data);
    }, onError: (error) {
      print('Ocorreu um erro: $error');
    }, onDone: () {
      print('Conexão com o jogador ${client.id} fechada');
      TempMemory().clientConnections.remove(index: client.id);
      client.socket.close();
    });
  }
}
