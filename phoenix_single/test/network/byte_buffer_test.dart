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
  });
}
