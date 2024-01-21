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
      var response = await _authRepository.sigIn(identity: identity, password: password);

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
}
