import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runanonymous/generated/l10n.dart';
import 'package:runanonymous/screen/result.dart';

class SpeedAverageList extends StatefulWidget {
  final GlobalKey<AnimatedListState> _animatedListStateKey = GlobalKey();
  final List<Result> _items;

  SpeedAverageList(this._items);

  @override
  _SpeedAverageListState createState() =>
      _SpeedAverageListState(_animatedListStateKey, _items);
}

class _SpeedAverageListState extends State<SpeedAverageList> {
  final List<Result> _initialItems;
  List<Result> _items = [];

  final GlobalKey<AnimatedListState> _globalKey;

  _SpeedAverageListState(this._globalKey, this._initialItems);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _addItems();
    S s = S.of(context);
    return SizedBox(
      height: 240,
      child: AnimatedList(
        key: _globalKey,
        initialItemCount: 0,
        padding: const EdgeInsets.all(10),
        itemBuilder: (_, index, animation) {
          final Result element = _items[index];
          return SizeTransition(
              key: UniqueKey(),
              sizeFactor: animation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(element.title, style: const TextStyle(fontSize: 22)),
                  Row(
                    children: _generateDisplayItems(element, s),
                  ),
                ],
              ));
        },
      ),
    );
  }

  List<Widget> _generateDisplayItems(Result element, S s) {
    var displayItems = [
      Text(element.result, style: const TextStyle(fontSize: 35)),
      Text(element.unit, style: const TextStyle(fontSize: 18)),
      Text(" (" + element.target + ")", style: const TextStyle(fontSize: 20)),
    ];

    return displayItems;
  }

  Future _addItems() async {
    const duration = Duration(milliseconds: 200);
    for (Result element in _initialItems) {
      await new Future.delayed(duration, () {
        _globalKey.currentState.insertItem(_items.length);
        _items.add(element);
      });
    }
  }
}
