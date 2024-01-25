import 'dart:io';

import '../data/models/alert/alert_model.dart';
import '../data/models/alert/alert_type.dart';
import '../data/models/network/client_connection/client_connection.dart';
import '../network/data_sender/senders/alert_sender.dart';
import '../utils/logger/logger.dart';
import 'client_handler.dart';
import 'memory/memory.dart';

class ClientManager {
  void handleNewClient(Socket socket) {
    var index = ServerMemory().clientConnections.getFirstEmptySlot();

    if (index == null) {
      _handleFullServer(socket);
    } else {
      _handleNewConnection(index, socket);
    }
  }

  void _handleFullServer(Socket socket) async {
    Logger(text: 'Número máximo de conexões alcançado', type: LoggerType.warning).log();

    var message = 'Servidor cheio. Tente novamente mais tarde.';
    var alert = AlertModel(title: 'Erro', message: message, type: AlertType.error);

    var tempClient = ClientConnectionModel(id: -1, socket: socket);

    AlertSender()(client: tempClient, alert: alert);

    await socket.flush();
    socket.close();
    Logger(text: 'Conexão com o socket ${socket.address} fechada', type: LoggerType.warning).log();
  }

  void _handleNewConnection(int index, Socket socket) {
    var client = ClientConnectionModel(id: index, socket: socket);
    ServerMemory().clientConnections.add(value: client);

    socket.done.then((_) {
      Logger(text: 'Cliente ${client.id} se desconectou.', type: LoggerType.player).log();
      ServerMemory().clientConnections.remove(index: client.id);
    });

    var handler = ClientHandler(client: client);
    handler.handleClient();
  }
}
