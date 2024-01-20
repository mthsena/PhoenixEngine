import 'package:phoenix_single/data/models/handle/handle_message_model.dart';
import 'package:phoenix_single/network/byte_buffer/byte_buffer.dart';

class LoginMessageHandler implements HandleMessageModel {
  final ByteBuffer _buffer = ByteBuffer();

  @override
  void handle({required int index, required List<int> data}) {
    _buffer.writeBytes(values: data);

    _buffer.readInteger();
    String username = _buffer.readString();
    print('Usuário: $username');

    _buffer.readInteger();
    String password = _buffer.readString();
    print('Senha: $password');
  }
}
