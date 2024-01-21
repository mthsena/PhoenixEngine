import 'dart:io';
import 'dart:convert';

import 'package:phoenix_single/data/models/alert/alert_type.dart';
import 'package:phoenix_single/data/packets/client_packets.dart';
import 'package:phoenix_single/data/packets/server_packets.dart';
import 'package:phoenix_single/network/byte_buffer/byte_buffer.dart';

void main() async {
  var socket = await Socket.connect('localhost', 7001);

  // Crie a mensagem de login
  var username = 'meuUsuario';
  var password = 'minhaSenha';

  // Codifique a mensagem de login em bytes
  var message = _createLoginMessage(username, password);

  // Envie a mensagem de login para o servidor
  socket.add(message);
  await socket.flush();

  // Adicione um ouvinte ao socket para receber a resposta do servidor
  socket.listen(
    (List<int> data) {
      var buffer = ByteBuffer();
      buffer.writeBytes(values: data);

      buffer.readInteger();

      var packetType = buffer.readByte();
      if (packetType == ServerPackets.alertMsg.index) {
        buffer.readInteger();
        var title = buffer.readString();

        buffer.readInteger();
        var message = buffer.readString();

        var type = AlertType.values[buffer.readInteger()];

        print('Alerta recebido do servidor:');
        print('Título: $title');
        print('Mensagem: $message');
        print('Tipo: $type');
      } else {
        print('outro tipo');
      }
    },
    onDone: () {
      print('Conexão fechada pelo servidor');
    },
    onError: (error) {
      print('Ocorreu um erro: $error');
    },
  );
}

List<int> _createLoginMessage(String username, String password) {
  var buffer = ByteBuffer();

  buffer.writeByte(value: ClientPackets.login.index);

  buffer.writeInteger(value: username.length);
  buffer.writeString(value: username);
  buffer.writeInteger(value: password.length);
  buffer.writeString(value: password);

  return buffer.toArray();
}
