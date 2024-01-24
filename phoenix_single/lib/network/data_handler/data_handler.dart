import '../../data/models/network/client_connection/client_connection.dart';
import '../../data/models/network/handle/handle_message_model.dart';
import '../../data/packets/client_packets.dart';
import '../../server/client_handler.dart';
import '../../utils/logger/logger.dart';
import '../byte_buffer/byte_buffer.dart';
import 'messages/menu_messages/sign_in_message.dart';
import 'messages/menu_messages/sign_up_message.dart';
import 'messages/placeholder_handle.dart';

class DataHandler {
  late List<HandleMessageModel> handleDataMessage;

  DataHandler() {
    handleDataMessage = List.filled(ClientPackets.values.length, PlaceholderHandler());
    _initMessages();
  }

  void _initMessages() {
    handleDataMessage[ClientPackets.login.index] = SignInMessageHandler();
    handleDataMessage[ClientPackets.signUp.index] = SignUpMessageHandler();
  }

  void handleData({required ClientConnectionModel client, required List<int> data}) {
    if (data.length < 4) return;

    ByteBuffer buffer = ByteBuffer();
    buffer.writeBytes(values: data);

    buffer.readInteger();

    int msgType = buffer.readInteger();

    try {
      if (msgType < 0 || msgType >= ClientPackets.values.length) {
        Logger(text: 'msgType fora do intervalo válido: $msgType', type: LoggerType.error).log();
      }

      handleDataMessage[msgType].handle(client: client, data: buffer.readBytes(length: buffer.length));
    } catch (e) {
      Logger(text: 'Erro: $e. Fechando a conexão com o cliente.', type: LoggerType.error).log();
      ClientHandler.disconnectClient(client: client);
    }
  }
}
