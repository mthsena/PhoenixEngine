import 'dart:io';

import '../data/models/alert/alert_model.dart';
import '../data/models/alert/alert_type.dart';
import '../data/models/network/client_connection/client_connection.dart';
import '../network/data_handler/data_handler.dart';
import '../network/data_sender/data_sender.dart';
import 'temp_memory.dart/temp_memory.dart';

class ServerSetup {
  final String address;
  final int port;

  ServerSetup({required this.address, required this.port});

  void startServer() async {
    try {
      final server = await ServerSocket.bind(address, port);
      print('Servidor escutando em ${server.address}:${server.port}');

      await for (var socket in server) {
        ClientManager().handleNewClient(socket);
      }
    } catch (e) {
      print('Ocorreu um erro ao iniciar o servidor: $e');
    }
  }
}

class ClientManager {
  final DataSender _dataSender = DataSender();

  void handleNewClient(Socket socket) {
    var index = TempMemory().clientConnections.getFirstEmptySlot();

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
    TempMemory().clientConnections.add(value: client);
    print('Cliente ${client.id} adicionado aos slots principais.');

    socket.done.then((_) {
      print('Cliente ${client.id} se desconectou.');
      TempMemory().clientConnections.remove(index: client.id);
    });

    // Aqui você pode adicionar a lógica para lidar com o novo cliente
  }
}

class ClientHandler {
  final int index;
  final Socket socket;

  ClientHandler({required this.index, required this.socket});

  void handleClient() {
    print('Recebendo conexão do jogador $index: ${socket.remoteAddress}:${socket.remotePort}');

    DataHandler dataHandler = DataHandler();

    socket.listen((data) {
      dataHandler.handleData(index: index, data: data);
    }, onError: (error) {
      print('Ocorreu um erro: $error');
    }, onDone: () {
      print('Conexão com o jogador $index fechada');
      TempMemory().clientConnections.remove(index: index);
      socket.close();
    });
  }
}
