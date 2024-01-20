import 'package:phoenix_single/data/packets/client_packets.dart';
import 'package:phoenix_single/network/data_handler/data_handler.dart';
import 'package:phoenix_single/network/data_handler/messages/placeholder_handle.dart';
import 'package:test/test.dart';

void main() {
  group('DataHandler', () {
    late DataHandler dataHandler;

    setUp(() {
      dataHandler = DataHandler();
    });

    test('inicializa handleDataMessage corretamente', () {
      expect(dataHandler.handleDataMessage.length, equals(ClientPackets.values.length));
      expect(dataHandler.handleDataMessage[0], isA<PlaceholderHandler>());
      // Verifique outros índices conforme necessário
    });

    test('handleData lança exceção para msgType fora do intervalo', () {
      expect(() => dataHandler.handleData(index: 0, data: [ClientPackets.values.length + 1, 0, 0, 0]), throwsRangeError);
    });
  });
}