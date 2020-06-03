class Memory {
  String _value = '0';

  void applyCommand(String command) {
    this._value += command;
  }

  String get value {
    return this._value;
  }
}
