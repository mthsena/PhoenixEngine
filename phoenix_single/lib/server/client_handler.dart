import '../models/network/client_connection/client_connection.dart';
import '../network/data/handler/data_handler.dart';
import '../utils/logger/logger.dart';
import '../utils/logger/logger_type.dart';
import 'server_memory.dart';

class ClientHandler {
  final ClientConnectionModel client;

  ClientHandler({required this.client});

  void handleClient() {
    DataHandler dataHandler = DataHandler();

    client.socket.listen((data) {
      print(data);
      dataHandler.handleData(client: client, data: data);
    }, onError: (error) {
      Logger(text: 'Ocorreu um erro: $error', type: LoggerType.error).log();
    }, onDone: () {
      disconnectClient(client: client);
    });
  }

  static void disconnectClient({required ClientConnectionModel client}) {
    Logger(text: 'Conexão com o jogador ${client.id} fechada', type: LoggerType.player).log();
    ServerMemory().clientConnections.remove(index: client.id);
    client.socket.close();
  }
}
