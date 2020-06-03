class Memory {
  String _value = '0';

  void applyCommand(String command) {
    if (command == 'AC')
      return this._allClear();

    this._value += command;
  }

  _allClear() {
    this._value = '0';
  }

  String get value {
    return this._value;
  }
}
