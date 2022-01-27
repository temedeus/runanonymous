import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_bloc.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_event.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_state.dart';
import 'package:runanonymous/common/unit/distance_unit.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';
import 'package:runanonymous/component/common/PaddedText.dart';
import 'package:runanonymous/component/speedometer/speedometer.dart';
import 'package:runanonymous/generated/l10n.dart';
import 'package:runanonymous/screen/tracking_page_arguments.dart';

import '../component/common/main_menu_button.dart';

/// Tracking page when user is running.
class TrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as TrackingPageArguments;
    final SpeedUnit speedUnitClear = args.speedUnitClear;
    final DistanceUnit distanceUnit = args.distanceUnit;
    final double targetDistance = args.targetDistance;
    final double targetSpeed = args.targetSpeed;

    final String targetSpeedAsString =
        targetSpeed != null ? targetSpeed.toStringAsFixed(1) : "--";
    final String targetSpeedText =
        S.of(context).runningTargetFormTargetSpeedText +
            targetSpeedAsString.toString() +
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
            distanceUnit.unit +
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
        builder:
            (BuildContext context, RunningProgressState runningProgressState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              PaddedText(
                  "${S.of(context).travelledDistance}:\n${runningProgressState.distanceTravelled.toStringAsFixed(2)} ${distanceUnit.unit}",
                  16),
              PaddedText(targetSpeedText, 24),
              Speedometer(targetSpeed, speedUnitClear),
              MenuButton(S.of(context).trackingScreenStopSession,
                  () => Navigator.pop(context)),
            ],
          );
        },
      ),
    );
  }
}
