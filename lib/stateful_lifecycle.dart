import 'package:flutter/material.dart';

class StatefulLifecycle extends StatefulWidget {
  final String text;

  const StatefulLifecycle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  _StatefulLifecycleState createState() => _StatefulLifecycleState();
}

class _StatefulLifecycleState extends State<StatefulLifecycle> {
  late bool _isLightTheme;

  @override
  void initState() {
    super.initState();
    print('initState');
    _isLightTheme = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  void didUpdateWidget(StatefulLifecycle oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget, was: ${oldWidget.text}, now: ${widget.text}');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('State Lifecycle'),
      ),
      body: GestureDetector(
        onTap: () => setState(() => _isLightTheme = !_isLightTheme),
        child: Container(
          color: _isLightTheme ? Colors.white : Colors.black,
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: TextStyle(
              color: _isLightTheme ? Colors.black : Colors.white,
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }
}
