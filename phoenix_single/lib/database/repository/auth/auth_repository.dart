import 'package:pocketbase/pocketbase.dart';

import '../../../utils/logger/logger.dart';
import '../../../utils/logger/logger_type.dart';
import '../../../utils/result/result.dart';

class AuthRepository {
  final _pb = PocketBase('http://127.0.0.1:8081');

  Future<Result<ClientException, RecordAuth>> signIn({
    required String identity,
    required String password,
  }) async {
    try {
      final RecordAuth recordAuth = await _pb.collection('users').authWithPassword(identity, password);

      return (null, recordAuth);
    } catch (error) {
      if (error is ClientException) {
        return (error, null);
      }

      Logger(text: 'Ocorreu um erro desconhecido ao realizar o login: $error', type: LoggerType.error).log();
      return (null, null);
    }
  }

  Future<Result<ClientException, RecordModel>> signUp({
    required String username,
    required String password,
    required String repeatPassword,
  }) async {
    Map<String, dynamic> body = {
      "username": username,
      "password": password,
      "passwordConfirm": repeatPassword,
    };

    try {
      RecordModel recordModel = await _pb.collection('users').create(body: body);

      return (null, recordModel);
    } catch (error) {
      if (error is ClientException) {
        return (error, null);
      }

      Logger(text: 'Ocorreu um erro desconhecido ao realizar o login: $error', type: LoggerType.error).log();
      return (null, null);
    }
  }
}
