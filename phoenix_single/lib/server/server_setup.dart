import 'dart:io';

import '../utils/logger/logger.dart';
import '../utils/logger/logger_type.dart';
import 'client_manager.dart';

class ServerSetup {
  final String address;
  final int port;

  ServerSetup({
    this.address = '127.0.0.1',
    this.port = 7001,
  });

  void startServer() async {
    try {
      Logger(text: 'Iniciando servidor...', type: LoggerType.info).log();
      Logger(text: 'Configurando o socket...', type: LoggerType.info).log();
      final server = await ServerSocket.bind(address, port);
      Logger(text: 'Servidor iniciado com sucesso!', type: LoggerType.info).log();
      Logger(text: 'Endereço: ${server.address.address}', type: LoggerType.info).log();
      Logger(text: 'Porta: ${server.port}', type: LoggerType.info).log();

      Logger(text: 'Aguardando conexões...', type: LoggerType.info).log();

      await for (var socket in server) {
        Logger(text: 'Nova conexão recebida: ${socket.remoteAddress.address}:${socket.remotePort}', type: LoggerType.player).log();
        ClientManager().handleNewClient(socket);
      }
    } catch (e) {
      Logger(text: 'Ocorreu um erro ao iniciar o servidor: $e', type: LoggerType.error).log();
    }
  }
}
