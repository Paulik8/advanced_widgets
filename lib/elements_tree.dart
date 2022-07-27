import 'package:flutter/material.dart';

class ElementsTreeExample extends StatefulWidget {
  const ElementsTreeExample({Key? key}) : super(key: key);

  @override
  State<ElementsTreeExample> createState() => _ElementsTreeExampleState();
}

class _ElementsTreeExampleState extends State<ElementsTreeExample> {
  IconData _iconData = Icons.flutter_dash;

  var _text = 'Flutter is coming';

  void _changeIcon() {
    setState(() {
      if (_iconData == Icons.flutter_dash) {
        _text = 'Winter is coming';
        _iconData = Icons.ac_unit;
      } else {
        _text = 'Flutter is coming';
        _iconData = Icons.flutter_dash;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _changeIcon,
                child: Icon(
                  _iconData,
                  size: 48,
                ),
              ),
              _iconData == Icons.flutter_dash
                  ? SizedBox(height: 20)
                  : Container(height: 20),
              Text(
                _text,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      );
}
