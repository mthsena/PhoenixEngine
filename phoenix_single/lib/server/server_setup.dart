import 'dart:io';

import 'client_manager.dart';

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
