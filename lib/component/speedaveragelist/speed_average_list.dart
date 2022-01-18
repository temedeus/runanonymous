import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpeedAverageList extends StatefulWidget {
  final GlobalKey<AnimatedListState> _globalKey;
  final _items;
  const SpeedAverageList(this._globalKey, this._items);

  @override
  _SpeedAverageListState createState() =>
      _SpeedAverageListState(_globalKey, _items);
}

class _SpeedAverageListState extends State<SpeedAverageList> {
  final _items;
  final GlobalKey<AnimatedListState> _globalKey;

  _SpeedAverageListState(this._globalKey, this._items);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: AnimatedList(
        key: _globalKey,
        initialItemCount: 0,
        padding: const EdgeInsets.all(10),
        itemBuilder: (_, index, animation) {
          return SizeTransition(
            key: UniqueKey(),
            sizeFactor: animation,
            child: Text(_items[index], style: const TextStyle(fontSize: 18)),
          );
        },
      ),
    );
  }
}
