class Memory {
  static const operations = const ['%', '/', 'x', '-', '+', '='];

  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String operation;
  String _value = '0';
  bool _wipeValue = false;

  void applyCommand(String command) {
    if (command == 'AC')
      return this._allClear();

    if (operations.contains(command))
      return this._setOperation(command);

    this._addDigit(command);
  }

  _setOperation(String newOperation) {
    this._wipeValue = true;
  }

  _addDigit(String digit) {
    final isDot = digit == ',';
    final wipeValue = (this._value == '0' && !isDot) || this._wipeValue;

    if (isDot && this._value.contains(',') && !wipeValue)
      return;

    final emptyValue = isDot ? '0' : '';
    final currentValue = wipeValue ? emptyValue : _value;

    this._value = currentValue + digit;
    this._wipeValue = false;
  }

  _allClear() {
    this._value = '0';
  }

  String get value {
    return this._value;
  }
}
