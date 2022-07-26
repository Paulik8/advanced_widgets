import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomPaintExample extends StatefulWidget {
  const CustomPaintExample({Key? key}) : super(key: key);

  @override
  State<CustomPaintExample> createState() => _CustomPaintExampleState();
}

class _CustomPaintExampleState extends State<CustomPaintExample> {
  static const _nonActiveColor = Colors.white;
  static const _activeColor = Colors.black26;

  final _viewModelList = <ShapeViewModel>[];
  int _currentIteration = -1;
  var _shapeMode = ShapeMode.circle;

  Color _getColorByMode(ShapeMode shapeMode) =>
      _shapeMode == shapeMode ? _activeColor : _nonActiveColor;

  void _changeShapeMode(ShapeMode shapeMode) {
    if (_shapeMode != shapeMode) {
      setState(() => _shapeMode = shapeMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ShapeChoice(
                    ShapeMode.circle,
                    _getColorByMode(ShapeMode.circle),
                    () => _changeShapeMode(ShapeMode.circle),
                  ),
                  ShapeChoice(
                    ShapeMode.rectangle,
                    _getColorByMode(ShapeMode.rectangle),
                    () => _changeShapeMode(ShapeMode.rectangle),
                  ),
                ],
              ),
            ),
            Divider(thickness: 4),
            Expanded(
              child: GestureDetector(
                onPanDown: (details) {
                  setState(() {
                    _currentIteration++;
                    _viewModelList.add(
                      ShapeViewModel(shapeMode: _shapeMode)
                        ..startPoint = details.localPosition,
                    );
                  });
                },
                onPanUpdate: (details) {
                  setState(
                    () => _viewModelList[_currentIteration]
                      ..endPoint = details.localPosition,
                  );
                },
                child: RepaintBoundary(
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: _Painter(
                      _currentIteration == -1
                          ? [ShapeViewModel(shapeMode: _shapeMode)]
                          : _viewModelList,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Clear'),
        onPressed: () => setState(() {
          _viewModelList.clear();
          _currentIteration = -1;
        }),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final List<ShapeViewModel> viewModelList;

  const _Painter(this.viewModelList);

  @override
  void paint(Canvas canvas, Size size) {
    print('paint');
    for (final viewModel in viewModelList) {
      final aPoint = viewModel.startPoint;
      final shapeMode = viewModel.shapeMode;
      if (aPoint != null) {
        Color color;
        switch (shapeMode) {
          case ShapeMode.rectangle:
            color = Colors.green;
            break;
          case ShapeMode.circle:
            color = Colors.orange;
            break;
        }
        var bPoint = viewModel.endPoint ?? aPoint;
        final minWidth = 2.0;
        final style = Paint()
          ..strokeCap = StrokeCap.round
          ..strokeWidth = minWidth
          ..color = color;
        final rect = Rect.fromPoints(aPoint, bPoint);
        if (shapeMode == ShapeMode.rectangle) {
          canvas.drawRect(rect, style);
        } else {
          final radius =
              math.sqrt(rect.width * rect.width + rect.height * rect.height) /
                  2;
          canvas.drawCircle(
            rect.center,
            radius,
            style,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _Painter oldDelegate) =>
      oldDelegate != this || oldDelegate.viewModelList != viewModelList;
}

class ShapeChoice extends StatelessWidget {
  final ShapeMode _shapeMode;
  final Color? _color;
  final VoidCallback _onTap;

  const ShapeChoice(
    this._shapeMode,
    this._color,
    this._onTap, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shape = BoxShape.circle;
    switch (_shapeMode) {
      case ShapeMode.circle:
        shape = BoxShape.circle;
        break;
      case ShapeMode.rectangle:
        shape = BoxShape.rectangle;
        break;
    }
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: shape,
          border: Border.all(),
          color: _color,
        ),
      ),
    );
  }
}

class ShapeViewModel {
  Offset? startPoint;
  Offset? endPoint;
  ShapeMode shapeMode;

  ShapeViewModel({
    required this.shapeMode,
    this.startPoint,
    this.endPoint,
  });
}

enum ShapeMode {
  rectangle,
  circle,
}
