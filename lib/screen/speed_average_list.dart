import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runanonymous/bloc/running_progress/speed_average_entry.dart';
import 'package:runanonymous/common/unit/distance_unit.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';
import 'package:runanonymous/generated/l10n.dart';

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
  List<String> _items = [];
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
          return SizeTransition(
            key: UniqueKey(),
            sizeFactor: animation,
            child: Text(_items[index], style: const TextStyle(fontSize: 18)),
          );
        },
      ),
    );
  }

  Future _addItems() async {
    const duration = Duration(milliseconds: 200);
    for (SpeedAverageEntry element in _initialItems) {
      String resultText = S.of(context).milestoneAt +
          " " +
          element.distancePoint.toStringAsFixed(1) +
          " " +
          _distanceUnit.unit +
          ": " +
          element.speedAverage.toStringAsFixed(1) +
          " " +
          _speedUnit.unit +
          " ${S.of(context).averageSpeed}";
      await new Future.delayed(duration, () {
        _globalKey.currentState.insertItem(_items.length);
        _items.add(resultText);
      });
    }
  }
}
