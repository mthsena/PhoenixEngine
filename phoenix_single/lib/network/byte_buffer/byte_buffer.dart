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
    _buffer = List.filled(_bufferSize, 0);
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

  void write(dynamic value, {Encoding encoding = ascii}) {
    if (value is int) {
      _writeInteger(value: value);
    } else if (value is String) {
      _writeString(value: value, encoding: encoding);
    } else if (value is List<int>) {
      _writeList(values: value);
    } else {
      throw ArgumentError('Unsupported value type');
    }
  }

  dynamic read(Type type, {Encoding encoding = ascii}) {
    if (type == int) {
      return _readInteger();
    } else if (type == String) {
      return _readString(encoding: encoding);
    } else if (type == List<int>) {
      return _readList(length: _readInteger());
    } else {
      throw ArgumentError('Unsupported type');
    }
  }

  void _writeList({required List<int> values}) {
    if (_writeHead + values.length > _bufferSize) _allocate(additionalSize: values.length);
    _buffer.setRange(_writeHead, _writeHead + values.length, values);
    _writeHead += values.length;
  }

  void _writeInteger({required int value}) {
    var byteData = ByteData(4)..setInt32(0, value, Endian.little);
    _writeList(values: byteData.buffer.asUint8List());
  }

  void _writeString({required String value, Encoding encoding = ascii}) {
    List<int> encodedString = encoding.encode(value);
    _writeInteger(value: encodedString.length);
    _writeList(values: encodedString);
  }

  List<int> _readList({required int length}) {
    var result = _buffer.sublist(_readHead, _readHead + length);
    _readHead += length;
    return result;
  }

  int _readInteger() {
    var byteData = ByteData.view(Uint8List.fromList(_readList(length: 4)).buffer);
    return byteData.getInt32(0, Endian.little);
  }

  String _readString({Encoding encoding = ascii}) {
    int length = _readInteger();
    String result = encoding.decode(_readList(length: length));
    return result;
  }

  List<int> getArray() {
    return _buffer;
  }

  String getString({Encoding encoding = ascii}) {
    return encoding.decode(_buffer);
  }
}
