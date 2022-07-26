import 'package:flutter/material.dart';

class TitleViewModel extends InheritedWidget {
  final String title;
  final Widget child;

  TitleViewModel({
    required this.title,
    required this.child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(TitleViewModel oldWidget) => oldWidget.title != title;

  // bool updateShouldNotify(TitleViewModel oldWidget) => true;

  static TitleViewModel? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TitleViewModel>();
}

class FirstLevelWidget extends StatelessWidget {
  const FirstLevelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('FirstLevelWidget build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Inherited'),
      ),
      body: const SecondLevelWidget(),
    );
  }
}

class SecondLevelWidget extends StatelessWidget {
  const SecondLevelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('SecondLevelWidget build');
    return const ThirdLevelWidget();
  }
}

class ThirdLevelWidget extends StatelessWidget {
  const ThirdLevelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ThirdLevelWidget build');
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.orange,
      ),
      alignment: Alignment.center,
      child: const FourthLevelWidget(),
    );
  }
}

class FourthLevelWidget extends StatefulWidget {
  const FourthLevelWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FourthLevelWidgetState();
}

class _FourthLevelWidgetState extends State<FourthLevelWidget> {
  late String _title;

  @override
  void initState() {
    super.initState();
    // _title = '${TitleViewModel.of(context)?.title ?? 'broken data'}';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _title = '${TitleViewModel.of(context)?.title ?? 'broken data'}';
    print('FourthLevelWidget didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('FourthLevelWidget build');
    // _title = 'SomeText';
    _title = '${TitleViewModel.of(context)?.title ?? 'broken data'}';
    return Text(
      _title,
      textDirection: TextDirection.ltr,
      style: TextStyle(
        color: Colors.black,
        fontSize: 40,
      ),
    );
  }
}
