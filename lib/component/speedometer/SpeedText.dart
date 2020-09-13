import 'package:flutter/material.dart';

class SpeedText extends StatelessWidget {
  SpeedText(this.speed);
  final double speed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        _convertToKmh(speed),
      ),
      decoration: new BoxDecoration(color: Colors.red),
      padding: new EdgeInsets.fromLTRB(64.0, 32.0, 64.0, 32.0),
    );
  }

  String _convertToKmh(double speed) {
    double speedInKmh = speed * 3.6;
    String speedString =
        (speedInKmh > 0.5) ? speedInKmh.toStringAsFixed(1) : "--";
    return speedString + " kmh";
  }
}
