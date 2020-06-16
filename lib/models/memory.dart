class Memory {
  static const operations = const ['+/-', '%', '/', 'x', '-', '+', '='];

  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String _operation;
  String _value = '0';
  bool _wipeValue = false;
  String _lastCommand;

  String get value {
    return _value;
  }

  _calculate() {
    switch (_operation) {
      case '+/-': return _buffer[0] * -1;
      case '%': return _buffer[0] / 100;
      case '/': return _buffer[0] / _buffer[1];
      case 'x': return _buffer[0] * _buffer[1];
      case '-': return _buffer[0] - _buffer[1];
      case '+': return _buffer[0] + _buffer[1];
      default: return _buffer[0];
    }
  }

  _addDigit(String digit) {
    final isDot = digit == '.';
    final wipeValue = (_value == '0' && !isDot) || _wipeValue;

    if (isDot && _value.contains('.') && !wipeValue)
      return;

    final emptyValue = isDot ? '0' : '';
    final currentValue = wipeValue ? emptyValue : _value;

    _value = currentValue + digit;
    _wipeValue = false;

    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
  }

  _setOperation(String operation) {
    bool isEqualSign = operation == '=';
    bool isPercent = operation == '%';
    bool isModulo = operation == '+/-';

    _wipeValue = true;

    if (isPercent || isModulo) {
      _operation = operation;
      _buffer[_bufferIndex] = _calculate();
      _value = _buffer[_bufferIndex].toString();
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;

      return;
    }

    if (_bufferIndex == 0 && !isEqualSign) {
      _operation = operation;
      _bufferIndex = 1;
      return;
    }

    if (_bufferIndex == 1) {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;

      _value = _buffer[0].toString();
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;

      _operation = isEqualSign ? null : operation;
      _bufferIndex = isEqualSign ? 0 : 1;
    }
  }

  _clearAll() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _operation = null;
    _bufferIndex = 0;
    _wipeValue = false;
  }

  _isReplacingOperation(String command) {
    return operations.contains(_lastCommand)
      && operations.contains(command)
      && _lastCommand != '='
      && command != '=';
  }

  void execute(String command) {
    if (_isReplacingOperation(command)) {
      _operation = command;
      return;
    }

    if (command == 'AC')
      return _clearAll();

    if (operations.contains(command))
      return _setOperation(command);

    _addDigit(command);
    _lastCommand = command;
  }
}
