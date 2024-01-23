/// `SlotManager` é uma classe genérica que gerencia uma lista de slots.
///
/// Cada slot pode conter um elemento de um tipo específico ou ser nulo, indicando que o slot está vazio.
class SlotManager<Element> {
  late List<Element?> _slots;

  /// Cria um novo gerenciador de slots com um tamanho específico.
  /// Todos os slots são inicialmente vazios.
  ///
  /// `size` é o número de slots a serem gerenciados.
  SlotManager({required int size}) {
    _slots = List<Element?>.filled(size, null);
  }

  /// Retorna o elemento no slot de índice especificado.
  /// Retorna null se o índice estiver fora do intervalo ou se o slot estiver vazio.
  ///
  /// `index` é o índice do slot a ser acessado.
  Element? operator [](int index) {
    return _checkIndex(index) ? _slots[index] : null;
  }

  /// Define o valor do slot no índice especificado.
  /// Se o índice estiver fora do intervalo, a operação é ignorada.
  ///
  /// `index` é o índice do slot a ser preenchido.
  /// `value` é o valor a ser colocado no slot.
  void operator []=(int index, Element? value) {
    if (_checkIndex(index)) {
      _slots[index] = value;
    }
  }

  /// Verifica se o slot no índice especificado está vazio.
  /// Retorna false se o índice estiver fora do intervalo.
  ///
  /// `index` é o índice do slot a ser verificado.
  bool isSlotEmpty({required int index}) {
    return _checkIndex(index) ? _slots[index] == null : false;
  }

  /// Retorna uma lista de índices de todos os slots preenchidos.
  List<int> getFilledSlots() {
    return _slots.asMap().entries.where((entry) {
      return entry.value != null;
    }).map((entry) {
      return entry.key;
    }).toList();
  }

  /// Retorna uma lista de índices de todos os slots vazios.
  List<int> getEmptySlots() {
    return _slots.asMap().entries.where((entry) {
      return entry.value == null;
    }).map((entry) {
      return entry.key;
    }).toList();
  }

  /// Remove o elemento no slot de índice especificado.
  /// Se o índice estiver fora do intervalo, a operação é ignorada.
  ///
  /// `index` é o índice do slot a ser esvaziado.
  void remove({required int index}) {
    if (_checkIndex(index)) {
      _slots[index] = null;
    }
  }

  /// Adiciona um elemento ao primeiro slot vazio encontrado.
  /// Lança um erro se não houver slots vazios disponíveis.
  ///
  /// `value` é o valor a ser adicionado.
  int add({required Element value}) {
    for (var i = 0; i < _slots.length; i++) {
      if (_slots[i] == null) {
        _slots[i] = value;
        return i;
      }
    }
    throw StateError('No empty slots available');
  }

  /// Retorna o índice do primeiro slot vazio encontrado.
  /// Retorna null se não houver slots vazios.
  int? getFirstEmptySlot() {
    var index = _slots.indexWhere((slot) => slot == null);
    return index != -1 ? index : null;
  }

  /// Retorna o número de slots vazios.
  int countEmptySlots() {
    return _slots.where((slot) => slot == null).length;
  }

  /// Retorna o número de slots preenchidos.
  int countFilledSlots() {
    return _slots.where((slot) => slot != null).length;
  }

  /// Retorna o índice do primeiro slot que contém o elemento especificado.
  /// Retorna -1 se o elemento não for encontrado.
  ///
  /// [element] é o elemento a ser procurado.
  int? find({required Element element}) {
    return _slots.indexWhere((slot) => slot == element);
  }

  /// Esvazia todos os slots.
  void clear() {
    for (var i = 0; i < _slots.length; i++) {
      _slots[i] = null;
    }
  }

  /// Verifica se o índice está dentro do intervalo válido.
  /// Lança um erro se o índice estiver fora do intervalo.
  ///
  /// `index` é o índice a ser verificado.
  bool _checkIndex(int index) {
    if (index < 0 || index >= _slots.length) {
      throw RangeError.index(index, _slots);
    }
    return true;
  }
}
