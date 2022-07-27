import 'package:flutter/material.dart';

class FirstLevelWidget extends StatelessWidget {
  final String title;

  const FirstLevelWidget({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Many Levels'),
        ),
        body: SecondLevelWidget(
          title: this.title,
        ),
      );
}

class SecondLevelWidget extends StatelessWidget {
  final String title;

  const SecondLevelWidget({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ThirdLevelWidget(
        title: this.title,
      );
}

class ThirdLevelWidget extends StatelessWidget {
  final String title;

  const ThirdLevelWidget({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
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
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        title,
        textDirection: TextDirection.ltr,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 40,
        ),
      );
}
