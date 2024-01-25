import '../../../../models/alert/alert_model.dart';
import '../../../../models/network/client_connection/client_connection.dart';
import '../../packets/server_packets.dart';
import '../../../buffer.dart';
import '../data_sender.dart';

class AlertSender {
  void call({required ClientConnectionModel client, required AlertModel alert}) {
    final PhoenixBuffer buffer = PhoenixBuffer();
    DataSender dataSender = DataSender();

    buffer.writeInteger(value: ServerPackets.alertMsg.index);

    buffer.writeString(value: alert.message);

    dataSender.sendDataTo(client: client, data: buffer.getArray());

    buffer.flush();
  }
}
