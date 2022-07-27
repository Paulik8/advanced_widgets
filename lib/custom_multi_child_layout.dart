import 'dart:math';

import 'package:flutter/material.dart';

class CustomMultiChildLayoutExample extends StatefulWidget {
  static const title = 'Flutter Custom Layout';

  const CustomMultiChildLayoutExample({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomMultiChildLayoutExample> createState() =>
      CustomMultiChildLayoutExampleState();
}

class CustomMultiChildLayoutExampleState
    extends State<CustomMultiChildLayoutExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(CustomMultiChildLayoutExample.title),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {});
          },
          child: SizedBox(
            height: 100.0,
            width: double.infinity,
            child: EvenSidesWidgets(
              lead: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                width: 50.0 + Random().nextDouble() * 50.0,
                color: Colors.cyan,
                alignment: Alignment.center,
                child: const Text('lead', textAlign: TextAlign.center),
              ),
              middle: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                color: Colors.lime,
                alignment: Alignment.center,
                child: const Text('middle', textAlign: TextAlign.center),
              ),
              trail: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                width: 50.0,
                color: Colors.indigo,
                alignment: Alignment.center,
                child: const Text('trail', textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EvenSidesWidgets extends CustomMultiChildLayout {
  final Widget lead;
  final Widget middle;
  final Widget trail;

  EvenSidesWidgets({
    required this.lead,
    required this.middle,
    required this.trail,
    Key? key,
  }) : super(
          key: key,
          delegate: EvenSidesWidgetsDelegate(),
          children: [
            LayoutId(id: EvenSidesWidgetsDelegate.lead, child: lead),
            LayoutId(id: EvenSidesWidgetsDelegate.middle, child: middle),
            LayoutId(id: EvenSidesWidgetsDelegate.trail, child: trail),
          ],
        );
}

class EvenSidesWidgetsDelegate extends MultiChildLayoutDelegate {
  static const lead = 'lead';
  static const middle = 'middle';
  static const trail = 'trail';

  @override
  void performLayout(Size size) {
    final leadSize = layoutChild(
      lead,
      BoxConstraints.loose(size).tighten(height: size.height),
    );
    final trailSize = layoutChild(
      trail,
      BoxConstraints.tight(leadSize),
    );

    final middleSize = Size(
      size.width - leadSize.width - trailSize.width,
      size.height,
    );
    layoutChild(middle, BoxConstraints.loose(middleSize));

    positionChild(
      lead,
      Offset.zero,
    );
    positionChild(
      middle,
      Offset(leadSize.width, 0.0),
    );
    positionChild(
      trail,
      Offset(leadSize.width + middleSize.width, 0.0),
    );
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}
