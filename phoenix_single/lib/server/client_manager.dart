import 'dart:io';

import '../data/models/alert/alert_model.dart';
import '../data/models/alert/alert_type.dart';
import '../data/models/network/client_connection/client_connection.dart';
import '../network/data_sender/data_sender.dart';
import 'client_handler.dart';
import 'memory/memory.dart';

class ClientManager {
  final DataSender _dataSender = DataSender();

  void handleNewClient(Socket socket) {
    var index = ServerMemory().clientConnections.getFirstEmptySlot();

    if (index == null) {
      _handleFullServer(socket);
    } else {
      _handleNewConnection(index, socket);
    }
  }

  void _handleFullServer(Socket socket) async {
    print('Número máximo de conexões alcançado');
    var message = 'Servidor cheio. Tente novamente mais tarde.';
    var alert = AlertModel(title: 'Erro', message: message, type: AlertType.error);

    var tempClient = ClientConnectionModel(id: -1, socket: socket);

    _dataSender.sendAlertMsg(client: tempClient, alert: alert);

    await socket.flush();
    socket.close();
  }

  void _handleNewConnection(int index, Socket socket) {
    var client = ClientConnectionModel(id: index, socket: socket);
    ServerMemory().clientConnections.add(value: client);
    print('Cliente ${client.id} adicionado aos slots principais.');

    socket.done.then((_) {
      print('Cliente ${client.id} se desconectou.');
      ServerMemory().clientConnections.remove(index: client.id);
    });

    var handler = ClientHandler(client: client);
    handler.handleClient();
  }
}
