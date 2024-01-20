import '../../data/model/handle/handle_message_model.dart';
import '../../data/packet/client_packets.dart';
import '../byte_buffer/byte_buffer.dart';
import 'message/placeholder_handle.dart';

class DataHandler {
  late List<HandleMessageModel> handleDataMessage;

  DataHandler() {
    handleDataMessage = List.filled(ClientPackets.values.length, PlaceholderHandler());
    _initMessages();
  }

  void _initMessages() {
    handleDataMessage[ClientPackets.login.index] = PlaceholderHandler();
    // outras
  }

  void handleData({required int index, required List<int> data}) {
    if (data.length < 4) return;

    ByteBuffer buffer = ByteBuffer();
    buffer.writeBytes(values: data);

    int msgType = buffer.readByte();

    if (msgType < 0 || msgType >= ClientPackets.values.length) {
      throw RangeError('msgType fora do intervalo válido: $msgType');
    }

    handleDataMessage[msgType].handle(index, buffer.readBytes(length: buffer.length));
  }
}
