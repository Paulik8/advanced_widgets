import 'package:advanced_widgets/elements_tree.dart';
import 'package:advanced_widgets/list_view.dart';
import 'package:advanced_widgets/render_proxy_box.dart';
import 'package:advanced_widgets/slivers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'custom_multi_child_layout.dart';
import 'custom_paint.dart';
import 'inherited.dart' as i;
import 'list_view_builder.dart';
import 'many_levels_problem.dart';
import 'stateful_lifecycle.dart';

enum Example {
  stateLifecycle,
  manyLevels,
  inherited,
  elementsTree,
  listView,
  listViewBuilder,
  slivers,
  customPaint,
  customMultiChildLayout,
  renderProxyBox,
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _title = 'Hello, world!';

  @override
  Widget build(BuildContext context) {
    final example = Example.manyLevels;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: _getExample(example)),
    );
  }

  Widget _getExample(Example example) {
    switch (example) {
      case Example.elementsTree:
        return ElementsTreeExample();
      case Example.stateLifecycle:
        return StatefulLifecycle(text: 'Hello, students!');
      case Example.manyLevels:
        return FirstLevelWidget(title: 'Hello, world!');
      case Example.inherited:
        return GestureDetector(
          onTap: () {
            setState(() {
              _title = 'Title is changed';
            });
          },
          child: i.TitleViewModel(
            title: _title,
            child: const i.FirstLevelWidget(),
          ),
        );
      case Example.listView:
        return const ListViewExample();
      case Example.listViewBuilder:
        return const ListViewBuilderExample();
      case Example.slivers:
        return SliversExample(childCount: 6);
      case Example.customPaint:
        return const CustomPaintExample();
      case Example.customMultiChildLayout:
        return const CustomMultiChildLayoutExample();
      case Example.renderProxyBox:
        return const RenderProxyBoxExample();
    }
  }
}
