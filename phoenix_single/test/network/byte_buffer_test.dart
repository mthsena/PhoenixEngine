import 'dart:convert';

import 'package:phoenix_single/network/byte_buffer/byte_buffer.dart';
import 'package:test/test.dart';

void main() {
  group('ByteBuffer', () {
    late ByteBuffer buffer;

    setUp(() {
      buffer = ByteBuffer();
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
      buffer.writeInteger(value: value.length);
      buffer.writeString(value: value, encoding: utf8);

      buffer.readInteger();
      expect(buffer.readString(encoding: utf8), value);
    });

    test('getArray', () {
      buffer.writeBytes(values: [65, 66, 67]);
      expect(buffer.getArray(), [65, 66, 67]);
    });

    test('getString', () {
      String value = 'Hello, World!';
      buffer.writeBytes(values: utf8.encode(value));
      expect(buffer.getString(encoding: utf8), value);
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
      buffer.writeInteger(value: title.length);
      buffer.writeString(value: title, encoding: utf8);
      buffer.writeInteger(value: message.length);
      buffer.writeString(value: message, encoding: utf8);
      buffer.writeInteger(value: errorCode);

      // Lê os valores do buffer
      int readHeader = buffer.readByte();
      buffer.readInteger();
      String readTitle = buffer.readString(encoding: utf8);
      buffer.readInteger();
      String readMessage = buffer.readString(encoding: utf8);
      int readErrorCode = buffer.readInteger();

      // Verifica se os valores lidos são iguais aos valores escritos
      expect(readHeader, header);
      expect(readTitle, title);
      expect(readMessage, message);
      expect(readErrorCode, errorCode);
    });
  });
}
