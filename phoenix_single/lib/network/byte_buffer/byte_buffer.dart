import 'dart:convert';
import 'dart:typed_data';

class ByteBuffer {
  List<int> _buffer = [];
  int _bufferSize = 0;
  int _writeHead = 0;
  int _readHead = 0;

  ByteBuffer() {
    _preAllocate(initialSize: 0);
  }

  int get count {
    return _buffer.length;
  }

  int get length {
    return count - _readHead;
  }

  void _preAllocate({required int initialSize}) {
    _writeHead = 0;
    _readHead = 0;
    _bufferSize = initialSize;
    _buffer = List.filled(_bufferSize, 0, growable: true);
  }

  void _allocate({required int additionalSize}) {
    _bufferSize += additionalSize;
    _buffer = List.from(_buffer, growable: true);
    _buffer.addAll(List.filled(additionalSize, 0));
  }

  void flush() {
    _writeHead = 0;
    _readHead = 0;
    _bufferSize = 0;
    _buffer = [];
  }

  void trim() {
    if (_readHead >= count) flush();
  }

  void writeByte({required int value}) {
    _ensureCapacity(1);
    _buffer[_writeHead++] = value;
  }

  void writeBytes({required List<int> values}) {
    _ensureCapacity(values.length);
    if (_writeHead + values.length > _bufferSize) _allocate(additionalSize: values.length);
    _buffer.setRange(_writeHead, _writeHead + values.length, values);
    _writeHead += values.length;
  }

  void writeInteger({required int value}) {
    var byteData = ByteData(4)..setInt32(0, value, Endian.little);
    _ensureCapacity(byteData.lengthInBytes);
    writeBytes(values: byteData.buffer.asUint8List());
  }

  void writeString({required String value, Encoding encoding = ascii}) {
    List<int> encodedString = encoding.encode(value);
    _ensureCapacity(4 + encodedString.length);
    writeInteger(value: encodedString.length);
    writeBytes(values: encodedString);
  }

  int readByte() {
    _checkRemaining(1);
    return _buffer[_readHead++];
  }

  List<int> readBytes({required int length}) {
    _checkRemaining(length);
    var result = _buffer.sublist(_readHead, _readHead + length);
    _readHead += length;
    return result;
  }

  int readInteger() {
    _checkRemaining(4);
    var byteData = ByteData.view(Uint8List.fromList(readBytes(length: 4)).buffer);
    return byteData.getInt32(0, Endian.little);
  }

  String readString({Encoding encoding = ascii}) {
    int length = readInteger();
    _checkRemaining(length);
    String result = encoding.decode(readBytes(length: length));
    return result;
  }

  List<int> getArray() {
    return _buffer;
  }

  String getString({Encoding encoding = ascii}) {
    return encoding.decode(_buffer);
  }

  void _ensureCapacity(int additionalSize) {
    if (_writeHead + additionalSize > _bufferSize) _allocate(additionalSize: additionalSize);
  }

  void _checkRemaining(int requiredSize) {
    if (_readHead + requiredSize > _bufferSize) throw Exception('Not enough bytes in the buffer');
  }
}
