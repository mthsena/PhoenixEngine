import '../../../../models/network/client_connection/client_connection.dart';
import '../../../buffer.dart';
import '../../packets/server_packets.dart';
import '../data_sender.dart';

class SenderID {
  void sendId({required ClientConnectionModel client, required int highId}) {
    final PhoenixBuffer buffer = PhoenixBuffer();
    DataSender dataSender = DataSender();

    buffer.writeInteger(value: ServerPackets.sendId.index);
    buffer.writeInteger(value: client.id);
    buffer.writeInteger(value: highId);

    dataSender.sendDataTo(client: client, data: buffer.getArray());

    buffer.flush();
  }

  void sendHighID({required int highId}) {
    final PhoenixBuffer buffer = PhoenixBuffer();
    DataSender dataSender = DataSender();

    buffer.writeInteger(value: ServerPackets.sendHighId.index);
    buffer.writeInteger(value: highId);

    dataSender.sendDataToAll(data: buffer.getArray());

    buffer.flush();
  }
}
