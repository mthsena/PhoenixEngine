import 'package:phoenix_single/data/models/network/handle/handle_message_model.dart';
import 'package:phoenix_single/network/byte_buffer/byte_buffer.dart';

class LoginMessageHandler implements HandleMessageModel {
  final ByteBuffer _buffer = ByteBuffer();

  @override
  void handle({required int index, required List<int> data}) {
    _buffer.writeBytes(values: data);

    print(_buffer.getArray());

    String username = _buffer.readString();

    String password = _buffer.readString();

    print('Username: $username, Password: $password');
  }
}
