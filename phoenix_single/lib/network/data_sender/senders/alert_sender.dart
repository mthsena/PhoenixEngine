import '../../../data/models/alert/alert_model.dart';
import '../../../data/models/network/client_connection/client_connection.dart';
import '../../../data/packets/server_packets.dart';
import '../../byte_buffer/byte_buffer.dart';
import '../data_sender.dart';

class AlertSender {
  void call({required ClientConnectionModel client, required AlertModel alert}) {
    final ByteBuffer buffer = ByteBuffer();
    DataSender dataSender = DataSender();

    buffer.writeInteger(value: ServerPackets.alertMsg.index);

    buffer.writeString(value: alert.message);

    dataSender.sendDataTo(client: client, data: buffer.getArray());

    buffer.flush();
  }
}
