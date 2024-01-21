import 'package:phoenix_single/data/models/network/handle/handle_message_model.dart';
import 'package:phoenix_single/network/byte_buffer/byte_buffer.dart';

class LoginMessageHandler implements HandleMessageModel {
  final ByteBuffer _buffer = ByteBuffer();

  @override
  void handle({required int index, required List<int> data}) {
    _buffer.writeBytes(values: data);

    print(_buffer.getArray());

    // _buffer.readByte(); // Skip the first byte

    // Read the username
    String username = _buffer.readString();

    // Read the password
    String password = _buffer.readString();

    // Now you have the username and password, you can handle them as needed
    print('Username: $username, Password: $password');
  }
}
