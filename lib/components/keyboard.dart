import 'package:flutter/material.dart';
import './button_row.dart';
import './button.dart';

class Keyboard extends StatelessWidget {
  final void Function(String) cb;

  Keyboard(this.cb);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: <Widget>[
          ButtonRow([
            Button(text: 'AC', color: Button.DARK, cb: cb),
            Button(text: '+/-', color: Button.DARK, cb: cb),
            Button(text: '%', color: Button.DARK, cb: cb),
            Button.operation(text: '/', cb: cb),
          ]),
          ButtonRow([
            Button(text: '7', cb: cb),
            Button(text: '8', cb: cb),
            Button(text: '9', cb: cb),
            Button.operation(text: 'x', cb: cb),
          ]),
          ButtonRow([
            Button(text: '4', cb: cb),
            Button(text: '5', cb: cb),
            Button(text: '6', cb: cb),
            Button.operation(text: '-', cb: cb)
          ]),
          ButtonRow([
            Button(text: '1', cb: cb),
            Button(text: '2', cb: cb),
            Button(text: '3', cb: cb),
            Button.operation(text: '+', cb: cb)
          ]),
          ButtonRow([
            Button.big(text: '0', cb: cb),
            Button(text: '.', cb: cb),
            Button.operation(text: '=', cb: cb)
          ]),
        ],
      ),
    );
  }
}
