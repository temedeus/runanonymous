import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runanonymous/component/speedometer/Speedometer.dart';

import '../component/common/MainMenuButton.dart';

class TrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Speedometer(),
        MainMenuButton("Stop Session", () => Navigator.pop(context)),
      ],
    );
  }
}
