import 'package:flutter/material.dart';

class ListViewBuilderExample extends StatelessWidget {
  const ListViewBuilderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemBuilder: (context, index) => Container(
          height: 80,
          alignment: Alignment.center,
          child: Text('list view builder item $index'),
          decoration: BoxDecoration(
            color: index.isEven ? Colors.black12 : Colors.black26,
          ),
        ),
        itemCount: 26,
      );
}
