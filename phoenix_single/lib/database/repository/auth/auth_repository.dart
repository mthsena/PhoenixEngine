import 'dart:convert';

import 'package:http/http.dart';

import '../../../data/models/database/auth/sign_in_response_model.dart';
import '../../../data/models/database/error/erro_model.dart';
import '../../../utils/result/result.dart';
import '../../http_client.dart';

class AuthRepository {
  final PhoenixHTTP phoenixHTTP = PhoenixHTTP();

  Future<Result<ErrorResponseModel, SignInResponseModel>> signIn({
    required String identity,
    required String password,
  }) async {
    const String url = 'http://127.0.0.1:8081/api/collections/users/auth-with-password';

    String body = jsonEncode(
      <String, dynamic>{
        "identity": identity,
        "password": password,
      },
    );

    Response response = await phoenixHTTP.post(url: url, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      SignInResponseModel signInResponseModel = SignInResponseModel.fromJson(body);

      return (null, signInResponseModel);
    } else {
      final Map<String, dynamic> body = jsonDecode(response.body);

      ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(body);

      return (errorResponseModel, null);
    }
  }

  Future<Result<ErrorResponseModel, AuthResponseModel>> signUp({
    required String username,
    required String password,
    required String repeatPassword,
  }) async {
    const String url = 'http://127.0.0.1:8081/api/collections/users/records';

    String body = jsonEncode(
      <String, dynamic>{
        "username": username,
        "password": password,
        "passwordConfirm": repeatPassword,
      },
    );

    Response response = await phoenixHTTP.post(url: url, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      AuthResponseModel authResponseRecordModel = AuthResponseModel.fromJson(body);

      return (null, authResponseRecordModel);
    } else {
      final Map<String, dynamic> body = jsonDecode(response.body);

      ErrorResponseModel errorResponseModel = ErrorResponseModel.fromJson(body);

      return (errorResponseModel, null);
    }
  }
}
