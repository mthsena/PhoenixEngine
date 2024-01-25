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

class SignUpMessageHandler implements HandleMessageModel {
  final PhoenixBuffer _buffer = PhoenixBuffer();
  final AuthService _authService = AuthService();

  @override
  void handle({required ClientConnectionModel client, required List<int> data}) async {
    _buffer.writeBytes(values: data);

    String username = _buffer.readString();
    print(username);

    String password = _buffer.readString();
    print(password);

    String passwordConfirm = _buffer.readString();
    print(passwordConfirm);

    (ErrorResponseModel?, AuthResponseModel?) signUp = await _authService.signUp(username: username, password: password, repeatPassword: passwordConfirm);

    late AlertModel alert;

    signUp.fold(
      success: (success) {
        alert = AlertModel(title: 'Sucesso', message: 'Cadastro realizado com sucesso!', type: AlertType.success);
      },
      failure: (failure) {
        alert = AlertModel(title: 'Erro', message: 'Nao foi possivel realizar o cadastro!', type: AlertType.success);
      },
    );

    AlertSender()(client: client, alert: alert);
  }
}
