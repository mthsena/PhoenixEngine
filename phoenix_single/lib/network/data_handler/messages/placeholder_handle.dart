import 'package:phoenix_single/data/models/network/client_connection/client_connection.dart';

import '../../../data/models/network/handle/handle_message_model.dart';

class PlaceholderHandler implements HandleMessageModel {
  @override
  void handle({required ClientConnectionModel client, required List<int> data}) {}
}
