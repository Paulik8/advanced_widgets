import 'package:flutter/material.dart';

class SliversExample extends StatefulWidget {
  final int childCount;

  const SliversExample({
    required this.childCount,
    Key? key,
  }) : super(key: key);

  @override
  State<SliversExample> createState() => _SliversExampleState();
}

class _SliversExampleState extends State<SliversExample> {
  bool _isLoading = false;

  Future<void> _requestMock() async {
    setState(() => _isLoading = true);
    await Future.delayed(
      Duration(seconds: 3),
      () => setState(() => _isLoading = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          collapsedHeight: 100,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Slivers'),
          ),
        ),
        if (!_isLoading)
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            sliver: SliverToBoxAdapter(
              child: MaterialButton(
                color: Colors.white24,
                onPressed: _requestMock,
                child: Text('Request!'),
              ),
            ),
          ),
        if (!_isLoading)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  height: 50,
                  child: Text(
                    'common item $index',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  decoration: BoxDecoration(color: Colors.green[100 * index]),
                );
              },
              childCount: widget.childCount,
            ),
          ),
        if (!_isLoading)
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            sliver: SliverToBoxAdapter(
              child: ColoredBox(
                color: Colors.black,
                child: const SizedBox(
                  height: 4,
                ),
              ),
            ),
          ),
        if (!_isLoading)
          SliverGrid(
            delegate: SliverChildListDelegate(
              List.generate(
                14,
                (index) => Container(
                  alignment: Alignment.center,
                  child: Text(
                    'grid item $index',
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.blue : Colors.green,
                    // shape: BoxShape.circle,
                  ),
                ),
              ).toList(),
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 2.0,
            ),
          ),
        if (_isLoading)
          SliverFillRemaining(
            // fillOverscroll: true,
            // hasScrollBody: false,
            child: const ColoredBox(
              color: Colors.tealAccent,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}
