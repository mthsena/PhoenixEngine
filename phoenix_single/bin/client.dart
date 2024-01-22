import 'dart:io';

import 'package:phoenix_single/network/byte_buffer/byte_buffer.dart';

void main() async {
  var socket = await Socket.connect('localhost', 7001);

  print('Digite seu nome de usuário:');
  String username = stdin.readLineSync()!;
  print('Digite sua senha:');
  String password = stdin.readLineSync()!;

  var message = _createLoginMessage(username, password);

  socket.add(message);
  await socket.flush();

  socket.listen(
    (List<int> data) {
      var buffer = ByteBuffer();
      buffer.writeBytes(values: data);

      buffer.readInteger();

      int packetType = buffer.readInteger();

      if (packetType == 0) {
        String message = buffer.readString();
        print(message);
      } else {
        print('Tipo de pacote desconhecido: $packetType');
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

  buffer.writeInteger(value: 0);
  buffer.writeString(value: username);
  buffer.writeString(value: password);

  return buffer.getArray();
}
