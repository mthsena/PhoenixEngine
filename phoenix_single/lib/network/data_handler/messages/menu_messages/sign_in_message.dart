import 'package:phoenix_single/utils/result/result.dart';

import '../../../../data/models/alert/alert_model.dart';
import '../../../../data/models/alert/alert_type.dart';
import '../../../../data/models/database/auth/sign_in_response_model.dart';
import '../../../../data/models/database/error/erro_model.dart';
import '../../../../data/models/network/client_connection/client_connection.dart';
import '../../../../data/models/network/handle/handle_message_model.dart';
import '../../../../database/services/auth_service.dart';
import '../../../byte_buffer/byte_buffer.dart';
import '../../../data_sender/data_sender.dart';

class SignInMessageHandler implements HandleMessageModel {
  final ByteBuffer _buffer = ByteBuffer();
  final DataSender _dataSender = DataSender();

  final AuthService _authService = AuthService();

  @override
  void handle({required ClientConnectionModel client, required List<int> data}) async {
    _buffer.writeBytes(values: data);

    String username = _buffer.readString();

    String password = _buffer.readString();

    (ErrorResponseModel?, SignInResponseModel?) sigIn = await _authService.sigIn(identity: username, password: password);

    late AlertModel alert;

    sigIn.fold(
      success: (SignInResponseModel signInResponseModel) {
        alert = AlertModel(title: 'Sucesso', message: 'Login realizado com sucesso!', type: AlertType.success);
      },
      failure: (ErrorResponseModel errorResponseModel) {
        alert = AlertModel(title: 'Erro', message: 'Nao foi possivel realizar o login!', type: AlertType.success);
      },
    );

    _dataSender.sendAlertMsg(client: client, alert: alert);
  }
}
