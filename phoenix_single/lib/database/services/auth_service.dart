import 'package:pocketbase/pocketbase.dart';

import '../../utils/result/result.dart';
import '../repository/auth/auth_repository.dart';

class AuthService {
  final AuthRepository _authRepository = AuthRepository();

  Future<Result<ClientException, RecordAuth>> sigIn({
    required String identity,
    required String password,
  }) async {
    var response = await _authRepository.signIn(identity: identity, password: password);

    if (response.isSuccess) {
      return (null, response.getSuccess);
    } else {
      return (response.getFailure, null);
    }
  }

  Future<Result<ClientException, RecordModel>> signUp({
    required String username,
    required String password,
    required String repeatPassword,
  }) async {
    var response = await _authRepository.signUp(username: username, password: password, repeatPassword: repeatPassword);

    if (response.isSuccess) {
      return (null, response.getSuccess);
    } else {
      return (response.getFailure, null);
    }
  }
}
