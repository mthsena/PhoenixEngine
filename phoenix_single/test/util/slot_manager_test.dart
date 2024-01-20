import 'package:phoenix_single/utils/slots_manager/slot_manager.dart';

import 'package:test/test.dart';

void main() {
  group('SlotManager', () {
    late SlotManager<int> manager;

    setUp(() {
      manager = SlotManager<int>(size: 5);
    });

    test('deve iniciar com todos os slots vazios', () {
      expect(manager.countEmptySlots(), equals(5));
      expect(manager.countFilledSlots(), equals(0));
    });

    test('deve adicionar elemento ao primeiro slot vazio', () {
      var index = manager.add(value: 1);
      expect(index, equals(0));
      expect(manager[0], equals(1));
    });

    test('deve lançar exceção ao tentar adicionar elemento sem slots vazios', () {
      for (var i = 0; i < 5; i++) {
        manager.add(value: i);
      }
      expect(() => manager.add(value: 6), throwsStateError);
    });

    test('deve remover elemento de um slot', () {
      manager.add(value: 1);
      manager.remove(index: 0);
      expect(manager.isSlotEmpty(index: 0), isTrue);
    });

    test('deve encontrar o índice de um elemento', () {
      manager.add(value: 1);
      var index = manager.find(element: 1);
      expect(index, equals(0));
    });

    test('deve limpar todos os slots', () {
      for (var i = 0; i < 5; i++) {
        manager.add(value: i);
      }
      manager.clear();
      expect(manager.countEmptySlots(), equals(5));
    });

    test('deve adicionar um elemento após o slot ser esvaziado', () {
      manager.add(value: 1);
      manager.remove(index: 0);
      expect(manager.isSlotEmpty(index: 0), isTrue);

      manager.add(value: 2);
      expect(manager[0], equals(2));
    });
  });
}
