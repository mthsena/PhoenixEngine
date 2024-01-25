import '../../../models/network/client_connection/client_connection.dart';
import '../../../server/server_memory.dart';
import '../../../utils/logger/logger.dart';
import '../../../utils/logger/logger_type.dart';
import '../../buffer.dart';

class DataSender {
  void sendDataTo({required ClientConnectionModel client, required List<int> data}) {
    try {
      final PhoenixBuffer buffer = PhoenixBuffer();

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
