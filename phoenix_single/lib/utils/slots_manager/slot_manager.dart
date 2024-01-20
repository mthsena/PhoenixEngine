class SlotManager<Element> {
  final List<Element?> _slots;

  SlotManager({required int size}) : _slots = List<Element?>.filled(size, null);

  Element? operator [](int index) {
    return _checkIndex(index) ? _slots[index] : null;
  }

  void operator []=(int index, Element? value) {
    if (_checkIndex(index)) {
      _slots[index] = value;
    }
  }

  bool isSlotEmpty({required int index}) {
    return _checkIndex(index) ? _slots[index] == null : false;
  }

  List<int> getFilledSlots() {
    return _slots.asMap().entries.where((entry) {
      return entry.value != null;
    }).map((entry) {
      return entry.key;
    }).toList();
  }

  List<int> getEmptySlots() {
    return _slots.asMap().entries.where((entry) {
      return entry.value == null;
    }).map((entry) {
      return entry.key;
    }).toList();
  }

  void remove({required int index}) {
    if (_checkIndex(index)) {
      _slots[index] = null;
    }
  }

  int add({required Element value}) {
    for (var i = 0; i < _slots.length; i++) {
      if (_slots[i] == null) {
        _slots[i] = value;
        return i;
      }
    }
    throw StateError('No empty slots available');
  }

  int? getFirstEmptySlot() {
    var index = _slots.indexWhere((slot) => slot == null);
    return index != -1 ? index : null;
  }

  int countEmptySlots() {
    return _slots.where((slot) => slot == null).length;
  }

  int countFilledSlots() {
    return _slots.where((slot) => slot != null).length;
  }

  int? find({required Element element}) {
    return _slots.indexWhere((slot) => slot == element);
  }

  void clear() {
    for (var i = 0; i < _slots.length; i++) {
      _slots[i] = null;
    }
  }

  bool _checkIndex(int index) {
    if (index < 0 || index >= _slots.length) {
      throw RangeError.index(index, _slots);
    }
    return true;
  }
}
