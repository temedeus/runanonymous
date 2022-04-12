import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runanonymous/bloc/running_progress/speed_average_entry.dart';
import 'package:runanonymous/common/unit/distance_unit.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';

class SpeedAverageList extends StatefulWidget {
  final GlobalKey<AnimatedListState> _animatedListStateKey = GlobalKey();
  final List<SpeedAverageEntry> _items;
  final SpeedUnit _speedUnit;
  final DistanceUnit _distanceUnit;
  SpeedAverageList(this._items, this._speedUnit, this._distanceUnit);

  @override
  _SpeedAverageListState createState() => _SpeedAverageListState(
      _animatedListStateKey, _items, this._speedUnit, this._distanceUnit);
}

class _SpeedAverageListState extends State<SpeedAverageList> {
  final List<SpeedAverageEntry> _initialItems;
  List _items = [];
  final SpeedUnit _speedUnit;
  final DistanceUnit _distanceUnit;

  final GlobalKey<AnimatedListState> _globalKey;

  _SpeedAverageListState(
      this._globalKey, this._initialItems, this._speedUnit, this._distanceUnit);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _addItems();

    return SizedBox(
      height: 180,
      child: AnimatedList(
        key: _globalKey,
        initialItemCount: 0,
        padding: const EdgeInsets.all(10),
        itemBuilder: (_, index, animation) {
          final SpeedAverageEntry element = _items[index];
          return SizeTransition(
              key: UniqueKey(),
              sizeFactor: animation,
              child: Row(
                children: [
                  Text(element.distancePoint.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 30)),
                  Text(_distanceUnit.unit + " - ",
                      style: const TextStyle(fontSize: 18)),
                  Text(element.speedAverage.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 30)),
                  Text(" ${_speedUnit.unit}",
                      style: const TextStyle(fontSize: 30)),
                ],
              ));
        },
      ),
    );
  }

  Future _addItems() async {
    const duration = Duration(milliseconds: 200);
    for (SpeedAverageEntry element in _initialItems) {
      await new Future.delayed(duration, () {
        _globalKey.currentState.insertItem(_items.length);
        _items.add(element);
      });
    }
  }
}
