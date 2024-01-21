import 'package:phoenix_single/data/models/alert/alert_model.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../data/models/alert/alert_type.dart';
import '../../../../data/models/network/client_connection/client_connection.dart';
import '../../../../data/models/network/handle/handle_message_model.dart';
import '../../../byte_buffer/byte_buffer.dart';
import '../../../data_sender/data_sender.dart';

class LoginMessageHandler implements HandleMessageModel {
  final ByteBuffer _buffer = ByteBuffer();
  final DataSender _dataSender = DataSender();

  final _pb = PocketBase('http://127.0.0.1:8090');

  @override
  void handle({required ClientConnectionModel client, required List<int> data}) async {
    _buffer.writeBytes(values: data);

    print(_buffer.getArray());

    String username = _buffer.readString();

    String password = _buffer.readString();

    try {
      await _pb.collection('users').authWithPassword(username, password);
    } catch (e) {
      print(e);
    }

    AlertModel alert = AlertModel(title: 'Sucesso', message: 'Login realizado com sucesso', type: AlertType.success);
    _dataSender.sendAlertMsg(client: client, alert: alert);
  }
}
