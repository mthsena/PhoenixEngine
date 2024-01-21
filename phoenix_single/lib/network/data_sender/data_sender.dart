import 'package:phoenix_single/data/packets/server_packets.dart';

import '../../data/models/alert/alert_model.dart';
import '../../data/models/network/client_connection/client_connection.dart';
import '../byte_buffer/byte_buffer.dart';

class DataSender {
  void sendDataTo({required ClientConnectionModel client, required List<int> data}) {
    try {
      final ByteBuffer buffer = ByteBuffer();

      buffer.writeInteger(value: data.length);
      buffer.writeBytes(values: data);

      client.socket.add(buffer.getArray());
    } catch (e) {
      print('Erro ao enviar dados para o cliente ${client.id}: $e');
    }
  }

  void sendAlertMsg({required ClientConnectionModel client, required AlertModel alert}) {
    final ByteBuffer buffer = ByteBuffer();

    buffer.writeInteger(value: ServerPackets.alertMsg.index);

    buffer.writeString(value: alert.message);

    sendDataTo(client: client, data: buffer.getArray());

    buffer.flush();
  }
}
