import 'package:flutter/material.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';
import 'package:runanonymous/common/util.dart';

import '../../common/unit/speed_status.dart';

class SpeedText extends StatelessWidget {
  SpeedText(this.speed, this.speedStatus, this.speedUnit, this.elapsed);
  final double speed;
  final SpeedStatus speedStatus;
  final SpeedUnit speedUnit;
  final Duration elapsed;

  @override
  Widget build(BuildContext context) {
    final util = Util();
    return Container(
      child: Text(
          _convertToDisplayValue(speed) +
              "\n" +
              util.parseStopWatchTime(elapsed),
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
      decoration: new BoxDecoration(
        color: colorStatus,
        borderRadius: BorderRadius.all(new Radius.circular(20.0)),
      ),
      padding: new EdgeInsets.fromLTRB(64.0, 32.0, 64.0, 32.0),
    );
  }

  Color get colorStatus {
    switch (speedStatus) {
      case SpeedStatus.FAST:
        return Colors.red;
      case SpeedStatus.ON_TIME:
        return Colors.greenAccent;
      case SpeedStatus.SLOW:
        return Colors.lightBlueAccent;
      default:
        return Colors.greenAccent;
    }
  }

  String _convertToDisplayValue(double speed) {
    String speedString =
        (speed > 0.5) ? speed.toStringAsFixed(1) + " " + speedUnit.unit : "--";
    return speedString;
  }
}
