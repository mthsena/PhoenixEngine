import '../../data/models/network/client_connection/client_connection.dart';
import '../../utils/slots_manager/slot_manager.dart';

class ServerMemory {
  static final ServerMemory _singletonInstance = ServerMemory._();

  factory ServerMemory() {
    return _singletonInstance;
  }

  ServerMemory._();

  SlotManager<ClientConnectionModel> clientConnections = SlotManager(size: 2);

  bool isConnected(int index) {
    return clientConnections.isSlotEmpty(index: index);
  }
}
