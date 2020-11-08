import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runanonymous/bloc/running_target_bloc.dart';
import 'package:runanonymous/common/speed_unit.dart';
import 'package:runanonymous/component/speedometer/speedometer.dart';

import '../component/common/main_menu_button.dart';

/// Tracking page when user is running.
class TrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        cubit: BlocProvider.of<RunningTargetBloc>(context),
        builder: (BuildContext context, state) {
          String targetSpeed =
              state.speed != null ? state.speed.toStringAsFixed(1) : "--";
          SpeedUnit speedUnitClear = state.speedUnit;
          String targetSpeedText = "Target speed: " +
              targetSpeed.toString() +
              " " +
              speedUnitClear.toShortString();

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  targetSpeedText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Speedometer(state.speed, state.distanceUnit),
              MainMenuButton("Stop Session", () => Navigator.pop(context)),
            ],
          );
        });
  }
}
