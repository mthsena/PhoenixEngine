import '../../data/models/database/auth/sign_in_response_model.dart';
import '../../data/models/database/error/erro_model.dart';
import '../../utils/result/result.dart';
import '../repository/auth/auth_repository.dart';

class AuthService {
  final AuthRepository _authRepository = AuthRepository();

  Future<Result<ErrorResponseModel, SignInResponseModel>> sigIn({
    required String identity,
    required String password,
  }) async {
    try {
      var response = await _authRepository.signIn(identity: identity, password: password);

      if (response.isSuccess) {
        return (null, response.getSuccess);
      } else {
        return (response.getFailure, null);
      }
    } catch (e) {
      ErrorResponseModel errorResponseModel = ErrorResponseModel(
        code: 500,
        message: e.toString(),
        data: {},
      );

      return (errorResponseModel, null);
    }
  }

  Future<Result<ErrorResponseModel, AuthResponseRecordModel>> signUp({
    required String username,
    required String password,
    required String repeatPassword,
  }) async {
    try {
      var response = await _authRepository.signUp(username: username, password: password, repeatPassword: repeatPassword);

      if (response.isSuccess) {
        return (null, response.getSuccess);
      } else {
        return (response.getFailure, null);
      }
    } catch (e) {
      print(e);

      ErrorResponseModel errorResponseModel = ErrorResponseModel(
        code: 500,
        message: e.toString(),
        data: {},
      );

      return (errorResponseModel, null);
    }
  }
}
