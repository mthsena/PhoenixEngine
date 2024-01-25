import '../../data/models/network/client_connection/client_connection.dart';
import '../../server/memory/memory.dart';
import '../../utils/logger/logger.dart';
import '../byte_buffer/byte_buffer.dart';

class DataSender {
  void sendDataTo({required ClientConnectionModel client, required List<int> data}) {
    try {
      final ByteBuffer buffer = ByteBuffer();

      buffer.writeInteger(value: data.length);
      buffer.writeBytes(values: data);

      client.socket.add(buffer.getArray());
    } catch (e) {
      Logger(text: 'Erro ao enviar dados para o cliente ${client.id}: $e', type: LoggerType.error).log();
    }
  }

  void sendDataToAll({required List<int> data}) {
    List<int> filledSlots = ServerMemory().clientConnections.getFilledSlots();

    for (var i in filledSlots) {
      ClientConnectionModel? slots = ServerMemory().clientConnections[i];

      if (ServerMemory().isConnected(i)) {
        if (slots != null) {
          sendDataTo(client: slots, data: data);
        }
      }
    }
  }

  void sendDataToAllBut({required ClientConnectionModel client, required List<int> data}) {
    List<int> filledSlots = ServerMemory().clientConnections.getFilledSlots();

    for (var i in filledSlots) {
      ClientConnectionModel? slots = ServerMemory().clientConnections[i];

      if (ServerMemory().isConnected(i)) {
        if (slots != null && slots.id != client.id) {
          sendDataTo(client: slots, data: data);
        }
      }
    }
  }
}
