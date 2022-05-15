import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_bloc.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_event.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_state.dart';
import 'package:runanonymous/common/route_mapping.dart';
import 'package:runanonymous/common/unit/distance_unit.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';
import 'package:runanonymous/common/util.dart';
import 'package:runanonymous/component/common/padded_text.dart';
import 'package:runanonymous/component/speedometer/speedometer.dart';
import 'package:runanonymous/generated/l10n.dart';
import 'package:runanonymous/screen/result.dart';
import 'package:runanonymous/screen/results_page_arguments.dart';
import 'package:runanonymous/screen/tracking_page_arguments.dart';

import '../component/common/main_menu_button.dart';

/// Tracking page when user is running.
class TrackingPage extends StatelessWidget {
  final _stopWatch = Stopwatch();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as TrackingPageArguments;
    final SpeedUnit speedUnitClear = args.speedUnitClear;
    final DistanceUnit distanceUnit = args.distanceUnit;
    final double targetDistance = args.targetDistance;
    final double targetSpeed = args.targetSpeed;

    BlocProvider.of<RunningProgressBloc>(context)
        .add(SetTargetDistance(targetDistance));

    return BlocBuilder(
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
            PaddedText(
                _createTargetSpeedText(context, targetSpeed, speedUnitClear),
                24),
            Speedometer(targetSpeed, speedUnitClear, _stopWatch),
            MenuButton(
                S.of(context).trackingScreenStopSession,
                () => _navigateToResultsPage(
                    context, runningProgressState, args)),
          ],
        );
      },
    );
  }

  _navigateToResultsPage(context, runningProgressState,
      TrackingPageArguments trackingPageArguments) {
    Navigator.pushReplacementNamed(context, RouteMapping.RESULTS.path,
        arguments: _generateResultsPageArguments(
            context, runningProgressState, trackingPageArguments));
  }

  _generateResultsPageArguments(
      BuildContext context,
      RunningProgressState runningProgressState,
      TrackingPageArguments trackingPageArguments) {
    final Util util = Util();
    var results = [
      Result(
        runningProgressState.averageSpeed.toStringAsFixed(2),
        trackingPageArguments.targetSpeed.toStringAsFixed(2),
        S.of(context).averageSpeed,
        trackingPageArguments.speedUnitClear.unit.toString(),
      ),
      Result(
        runningProgressState.distanceTravelled.toStringAsFixed(2),
        trackingPageArguments.targetDistance.toStringAsFixed(2),
        S.of(context).travelledDistance,
        trackingPageArguments.distanceUnit.unit.toString(),
      ),
      Result(
        util.parseStopWatchTime(_stopWatch.elapsed),
        util.parseStopWatchTime(Duration(
            hours: trackingPageArguments.targetTime.hour,
            minutes: trackingPageArguments.targetTime.minute,
            seconds: trackingPageArguments.targetTime.seconds)),
        S.of(context).runningTime,
        "hh:mm:ss",
      )
    ];

    return ResultsPageArguments(results);
  }

  _createTargetSpeedText(context, targetSpeed, SpeedUnit speedUnitClear) {
    final String targetSpeedAsString =
        targetSpeed != null ? targetSpeed.toStringAsFixed(1) : "--";
    return S.of(context).runningTargetFormTargetSpeedText +
        targetSpeedAsString.toString() +
        " " +
        speedUnitClear.unit;
  }
}
