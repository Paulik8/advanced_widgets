import 'package:flutter/material.dart';

class ListViewExample extends StatelessWidget {
  const ListViewExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          ...List.generate(
            20,
            (index) => Container(
              height: 80,
              alignment: Alignment.center,
              child: Text('list view item $index'),
              decoration: BoxDecoration(
                color: index.isEven ? Colors.black12 : Colors.black26,
              ),
            ),
          ),
        ],
      );
}
