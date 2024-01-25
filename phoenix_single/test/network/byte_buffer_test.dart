import 'dart:convert';

import 'package:phoenix_single/network/buffer.dart';
import 'package:test/test.dart';

void main() {
  group('PhoenixBuffer', () {
    late PhoenixBuffer buffer;

    setUp(() {
      buffer = PhoenixBuffer();
    });

    test('writeByte and readByte', () {
      buffer.writeByte(value: 65);
      expect(buffer.readByte(), 65);
    });

    test('writeBytes and readBytes', () {
      buffer.writeBytes(values: [65, 66, 67]);
      expect(buffer.readBytes(length: 3), [65, 66, 67]);
    });

    test('writeInteger and readInteger', () {
      buffer.writeInteger(value: 123456);
      expect(buffer.readInteger(), 123456);
    });

    test('writeString and readString', () {
      String value = 'Hello, World!';
      buffer.writeString(value: value);

      expect(buffer.readString(), value);
    });

    test('getArray', () {
      buffer.writeBytes(values: [65, 66, 67]);
      expect(buffer.getArray(), [65, 66, 67]);
    });

    test('getString', () {
      String value = 'Hello, World!';
      buffer.writeBytes(values: utf8.encode(value));
      expect(buffer.toString(), value);
    });

    test('flush', () {
      buffer.writeBytes(values: [65, 66, 67]);
      buffer.flush();
      expect(buffer.getArray(), []);
    });

    test('trim', () {
      buffer.writeBytes(values: [65, 66, 67]);
      buffer.readBytes(length: 3);
      buffer.trim();
      expect(buffer.getArray(), []);
    });

    test('write and read alert message', () {
      int header = 0;
      String title = 'Alerta';
      String message = 'Algo deu errado';
      int errorCode = 404;

      // Escreve os valores no buffer
      buffer.writeByte(value: header);
      buffer.writeString(value: title);
      buffer.writeString(value: message);
      buffer.writeInteger(value: errorCode);

      print('Buffer após a escrita: ${buffer.getArray()}');

      // Lê os valores do buffer
      int readHeader = buffer.readByte();
      String readTitle = buffer.readString();
      print('Título lido: $readTitle');
      String readMessage = buffer.readString();
      print('Mensagem lida: $readMessage');
      int readErrorCode = buffer.readInteger();

      // Verifica se os valores lidos são iguais aos valores escritos
      expect(readHeader, header);
      expect(readTitle, title);
      expect(readMessage, message);
      expect(readErrorCode, errorCode);
    });
  });
}
