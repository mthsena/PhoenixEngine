import '../../../../../models/alert/alert_model.dart';
import '../../../../../models/alert/alert_type.dart';
import '../../../../../models/database/auth/sign_in_response_model.dart';
import '../../../../../models/database/error/erro_model.dart';
import '../../../../../models/network/client_connection/client_connection.dart';
import '../../../../../models/network/handle/handle_message_model.dart';
import '../../../../../database/services/auth_service.dart';
import '../../../../../utils/result/result.dart';
import '../../../../buffer.dart';
import '../../../sender/senders/alert_sender.dart';

class SignInMessageHandler implements HandleMessageModel {
  final PhoenixBuffer _buffer = PhoenixBuffer();

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

    AlertSender()(client: client, alert: alert);
  }
}
