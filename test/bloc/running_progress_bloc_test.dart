import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_bloc.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_datapoint.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_event.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_state.dart';
import 'package:runanonymous/bloc/running_progress/speed_average_entry.dart';

void main() {
  RunningProgressState _initialState = RunningProgressState(
    averageSpeeds: [],
    speedSumDataPoint: 0,
    distanceTravelled: 0,
    speedSumTotal: 0,
    distanceDataPointCounter: 0,
    targetDistance: 0,
  );

  RunningProgressState createState({
    averageSpeeds,
    speedSumDataPoint,
    distanceTravelled,
    speedSumTotal,
    distanceDataPointCounter,
    targetDistance,
  }) {
    return RunningProgressState(
      averageSpeeds: averageSpeeds ?? _initialState.averageSpeeds,
      speedSumDataPoint: speedSumDataPoint ?? _initialState.speedSumDataPoint,
      distanceTravelled: distanceTravelled ?? _initialState.distanceTravelled,
      speedSumTotal: speedSumTotal ?? _initialState.speedSumTotal,
      distanceDataPointCounter:
          distanceDataPointCounter ?? _initialState.distanceDataPointCounter,
      targetDistance: targetDistance ?? _initialState.targetDistance,
    );
  }

  group('RunningProgressBloc', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => RunningProgressBloc(),
      expect: () => [],
    );

    blocTest(
      'emits initial state when UpdateSpeedUnitEvent is added',
      build: () => RunningProgressBloc(),
      act: (bloc) => bloc.add(ResetFormEvent()),
      expect: () => [_initialState],
    );

    blocTest(
      'emits running progress with target distance when SetTargetDistance is added',
      build: () => RunningProgressBloc(),
      act: (bloc) => bloc.add(SetTargetDistance(100.toDouble())),
      expect: () => [createState(targetDistance: 100.toDouble())],
    );

    blocTest(
        'emits running progress with updated distance/speed when UpdateRunningProgressEvent is added (twice)',
        build: () => RunningProgressBloc(),
        skip: 1,
        act: (bloc) => bloc
          ..add(SetTargetDistance(100.toDouble()))
          ..add(UpdateRunningProgressEvent(RunningProgressDatapoint(2, 4)))
          ..add(UpdateRunningProgressEvent(RunningProgressDatapoint(2, 4))),
        expect: () => [
              createState(
                speedSumTotal: 2.toDouble(),
                speedSumDataPoint: 2.toDouble(),
                targetDistance: 100.toDouble(),
                distanceTravelled: 4.toDouble(),
                distanceDataPointCounter: 1,
              ),
              createState(
                speedSumTotal: 4.toDouble(),
                speedSumDataPoint: 4.toDouble(),
                targetDistance: 100.toDouble(),
                distanceTravelled: 8.toDouble(),
                distanceDataPointCounter: 2,
              )
            ]);
  });

  blocTest(
      'emits running progress with updated speed/distance when UpdateRunningProgressEvent is added and milestone reached',
      build: () => RunningProgressBloc(),
      skip: 1,
      act: (bloc) => bloc
        ..add(SetTargetDistance(50.toDouble()))
        ..add(UpdateRunningProgressEvent(RunningProgressDatapoint(2, 2)))
        ..add(UpdateRunningProgressEvent(RunningProgressDatapoint(13, 28))),
      expect: () => [
            createState(
              speedSumTotal: 2.toDouble(),
              speedSumDataPoint: 2.toDouble(),
              targetDistance: 50.toDouble(),
              distanceTravelled: 2.toDouble(),
              distanceDataPointCounter: 1,
            ),
            createState(
              averageSpeeds: [SpeedAverageEntry(30.0, 7.5)],
              speedSumTotal: 15.toDouble(),
              speedSumDataPoint: 0.toDouble(),
              targetDistance: 50.toDouble(),
              distanceTravelled: 30.toDouble(),
              distanceDataPointCounter: 0,
            ),
          ]);
}
