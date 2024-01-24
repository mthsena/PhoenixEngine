import 'dart:io';

import 'client_manager.dart';

class ServerSetup {
  final String address;
  final int port;

  ServerSetup({required this.address, required this.port});

  void startServer() async {
    try {
      print('Iniciando servidor...');
      print('Configurando o socket...');
      final server = await ServerSocket.bind(address, port);
      print('Servidor iniciado com sucesso!');
      print('Endereço: ${server.address.address}');
      print('Porta: ${server.port}');

      print('Aguardando conexões...');

      await for (var socket in server) {
        print('Nova conexão recebida: ${socket.remoteAddress.address}:${socket.remotePort}');
        ClientManager().handleNewClient(socket);
      }
    } catch (e) {
      print('Ocorreu um erro ao iniciar o servidor: $e');
    }
  }
}
