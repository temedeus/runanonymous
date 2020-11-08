import 'package:flutter/material.dart';

import '../../common/speed_status.dart';

class SpeedText extends StatelessWidget {
  SpeedText(this.speed, this.speedStatus);
  final double speed;
  final SpeedStatus speedStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(_convertToKmh(speed),
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
      decoration: new BoxDecoration(color: colorStatus),
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

  String _convertToKmh(double speed) {
    String speedString = (speed > 0.5) ? speed.toStringAsFixed(1) : "--";
    return speedString + " kmh";
  }
}
