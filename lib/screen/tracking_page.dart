import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_bloc.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_event.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_state.dart';
import 'package:runanonymous/bloc/running_target/running_target_bloc.dart';
import 'package:runanonymous/bloc/running_target/running_target_state.dart';
import 'package:runanonymous/common/unit/distance_unit.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';
import 'package:runanonymous/component/common/PaddedText.dart';
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
          builder:
              (BuildContext context, RunningTargetState runningTargetState) {
            String targetSpeed = runningTargetState.speed != null
                ? runningTargetState.speed.toStringAsFixed(1)
                : "--";
            SpeedUnit speedUnitClear = runningTargetState.speedUnit;
            DistanceUnit distanceUnit = runningTargetState.distanceUnit;
            double targetDistance = runningTargetState.distance;
            String targetSpeedText =
                S.of(context).runningTargetFormTargetSpeedText +
                    targetSpeed.toString() +
                    " " +
                    speedUnitClear.unit;
            int lastIndex = 0;

            BlocProvider.of<RunningProgressBloc>(context)
                .add(SetTargetDistance(targetDistance));

            return BlocListener<RunningProgressBloc, RunningProgressState>(
              listenWhen: (context, runningProgressState) {
                return runningProgressState.averageSpeeds.length > lastIndex;
              },
              listener: (context, runningProgressState) {
                lastIndex++;
                var speedAverage = runningProgressState.averageSpeeds.last;
                String snackBarText = S.of(context).milestoneAt +
                    " " +
                    speedAverage.distancePoint.toStringAsFixed(1) +
                    " " +
                    runningTargetState.distanceUnit.unit +
                    ": " +
                    speedAverage.speedAverage.toStringAsFixed(1) +
                    " " +
                    speedUnitClear.unit +
                    " ${S.of(context).averageSpeed}";

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(snackBarText),
                ));
              },
              child: BlocBuilder(
                bloc: BlocProvider.of<RunningProgressBloc>(context),
                builder: (BuildContext context,
                    RunningProgressState runningProgressState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      PaddedText(
                          "${S.of(context).travelledDistance}: \n${runningProgressState.distanceTravelled.toStringAsFixed(2)} ${distanceUnit.unit}",
                          16),
                      PaddedText(targetSpeedText, 24),
                      Speedometer(runningTargetState.speed,
                          runningTargetState.speedUnit),
                      MenuButton(S.of(context).trackingScreenStopSession,
                          () => Navigator.pop(context)),
                    ],
                  );
                },
              ),
            );
          }),
    );
  }
}
