import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RenderProxyBoxExample extends StatelessWidget {
  const RenderProxyBoxExample({Key? key}) : super(key: key);

  static const title = 'Flutter RenderProxyBox';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _RenderProxyBoxPage(),
    );
  }
}

class _RenderProxyBoxPage extends StatefulWidget {
  const _RenderProxyBoxPage({
    Key? key,
  }) : super(key: key);

  @override
  State<_RenderProxyBoxPage> createState() => _RenderProxyBoxPageState();
}

class _RenderProxyBoxPageState extends State<_RenderProxyBoxPage> {
  bool block = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(RenderProxyBoxExample.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Blocking: $block'),
            BlockTouches(
              block: block,
              child: ElevatedButton(
                onPressed: () {
                  print('tap');
                },
                child: const Text('Tap me'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  block = !block;
                });
              },
              child: const Text('Toggle'),
            ),
          ],
        ),
      ),
    );
  }
}

class BlockTouches extends SingleChildRenderObjectWidget {
  final bool block;

  const BlockTouches({
    required this.block,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) =>
      BlockTouchesRenderObject(block);

  @override
  void updateRenderObject(
    BuildContext context,
    RenderObject renderObject,
  ) {
    if (renderObject is BlockTouchesRenderObject) {
      renderObject.block = block;
    }
  }
}

class BlockTouchesRenderObject extends RenderProxyBox {
  bool block;

  BlockTouchesRenderObject(this.block);

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (block) {
      return size.contains(position);
    }
    return super.hitTest(result, position: position);
  }
}
