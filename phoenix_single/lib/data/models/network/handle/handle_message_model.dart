import '../client_connection/client_connection.dart';

abstract interface class HandleMessageModel {
  void handle({required ClientConnectionModel client, required List<int> data});
}
