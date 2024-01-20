import '../../data/models/network/client_connection/client_connection.dart';
import '../../utils/slots_manager/slot_manager.dart';

class TempMemory {
  static final TempMemory _singletonInstance = TempMemory._();

  factory TempMemory() {
    return _singletonInstance;
  }

  TempMemory._();

  SlotManager<ClientConnectionModel> clientConnections = SlotManager(size: 2);

  bool isConnected(int index) {
    return clientConnections.isSlotEmpty(index: index);
  }
}
