import 'package:http/http.dart';

class PhoenixHTTP {
  final client = Client();

  Future<Response> get({required String url, Map<String, String>? headers}) async {
    return await client.get(
      Uri.parse(url),
      headers: headers,
    );
  }

  Future<Response> post({required String url, required dynamic body}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    return await client.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
  }

  Future<Response> delete({required String url, Map<String, String>? headers}) async {
    return await client.delete(
      Uri.parse(url),
      headers: headers,
    );
  }

  Future<Response> put({required String url, required dynamic body, Map<String, String>? headers}) async {
    return await client.put(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
  }
}
