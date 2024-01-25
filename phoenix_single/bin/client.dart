import 'dart:io';

import 'package:phoenix_single/network/buffer.dart';

void main() async {
  final PhoenixBuffer buffer = PhoenixBuffer();

  var socket = await Socket.connect('localhost', 7001);
  print('Conectado ao servidor');

  print('Digite o usuário:');
  late String username;
  username = stdin.readLineSync() ?? 'matheus';
  print('Digite a senha:');
  late String password;
  password = stdin.readLineSync() ?? 'matheus';

  List<int> message = _createLoginMessage(username, password);
  int length = message.length;

  buffer.writeInteger(value: length);
  buffer.writeBytes(values: message);

  var data = buffer.getArray();

  socket.add(data);
  await socket.flush();

  socket.listen(
    (List<int> data) {
      final PhoenixBuffer reader = PhoenixBuffer();

      reader.writeBytes(values: data);

      reader.readInteger();

      int packetType = reader.readInteger();

      if (packetType == 0) {
        String message = reader.readString();
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
  var buffer = PhoenixBuffer();

  buffer.writeInteger(value: 0);
  buffer.writeString(value: username);
  buffer.writeString(value: password);

  return buffer.getArray();
}
