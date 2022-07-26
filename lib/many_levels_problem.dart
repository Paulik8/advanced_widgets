import 'package:flutter/material.dart';

class FirstLevelWidget extends StatelessWidget {
  final String title;

  const FirstLevelWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Many Levels'),
        ),
        body: SecondLevelWidget(
          title: this.title,
        ),
      );
}

class SecondLevelWidget extends StatelessWidget {
  final String title;

  const SecondLevelWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) => ThirdLevelWidget(
        title: this.title,
      );
}

class ThirdLevelWidget extends StatelessWidget {
  final String title;

  const ThirdLevelWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.orange,
        ),
        alignment: Alignment.center,
        child: FourthLevelWidget(
          title: title,
        ),
      );
}

class FourthLevelWidget extends StatelessWidget {
  final String title;

  FourthLevelWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        title,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          color: Colors.black,
          fontSize: 40,
        ),
      );
}
