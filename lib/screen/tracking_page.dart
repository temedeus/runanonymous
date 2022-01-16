import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_bloc.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_state.dart';
import 'package:runanonymous/bloc/running_target/running_target_bloc.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';
import 'package:runanonymous/component/speedaveragelist/speed_average_list.dart';
import 'package:runanonymous/component/speedometer/speedometer.dart';
import 'package:runanonymous/generated/l10n.dart';

import '../component/common/main_menu_button.dart';

/// Tracking page when user is running.
class TrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RunningProgressBloc>(
      create: (BuildContext context) => RunningProgressBloc(),
      child: BlocBuilder(
          bloc: BlocProvider.of<RunningTargetBloc>(context),
          builder: (BuildContext context, runningTargetState) {
            String targetSpeed = runningTargetState.speed != null
                ? runningTargetState.speed.toStringAsFixed(1)
                : "--";
            SpeedUnit speedUnitClear = runningTargetState.speedUnit;
            String targetSpeedText =
                S.of(context).runningTargetFormTargetSpeedText +
                    targetSpeed.toString() +
                    " " +
                    speedUnitClear.unit;

            final GlobalKey<AnimatedListState> _animatedListStateKey =
                GlobalKey();
            final _items = [];

            return BlocListener<RunningProgressBloc, RunningProgressState>(
              listenWhen: (context, runningProgressState) {
                return runningProgressState.averageSpeeds.length >
                    _items.length;
              },
              listener: (context, runningProgressState) {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SpeedAverageList(_animatedListStateKey, _items),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      targetSpeedText,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Speedometer(
                      runningTargetState.speed, runningTargetState.speedUnit,
                      (speed) {
                    _animatedListStateKey.currentState.insertItem(_items.length,
                        duration: const Duration(seconds: 1));
                    _items.add("Milestone ${_items.length + 1}: $speed");
                  }),
                  MenuButton(S.of(context).trackingScreenStopSession,
                      () => Navigator.pop(context)),
                ],
              ),
            );
          }),
    );
  }
}
