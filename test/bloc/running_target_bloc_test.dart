import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:runanonymous/bloc/running_target/running_target_bloc.dart';
import 'package:runanonymous/bloc/running_target/running_target_state.dart';
import 'package:runanonymous/bloc/running_target/running_time.dart';
import 'package:runanonymous/bloc/running_target/running_time_event.dart';
import 'package:runanonymous/common/unit/distance_unit.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';

void main() {
  RunningTargetState _initialState = RunningTargetState(
      distance: 0,
      time: new RunningTime(0, 0, 0),
      distanceUnit: DistanceUnit.KM,
      speed: 0,
      speedUnit: SpeedUnit.KMH);

  RunningTargetState createOnInitialState({
    distance,
    distanceUnit,
    time,
    speed,
    speedUnit,
  }) {
    return RunningTargetBloc().fromOldSettingState(_initialState,
        distance: distance ?? _initialState.distance,
        distanceUnit: distanceUnit ?? _initialState.distanceUnit,
        time: time ?? _initialState.time,
        speed: speed ?? _initialState.speed,
        speedUnit: speedUnit ?? _initialState.speedUnit);
  }

  group('RunningTargetBloc', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => RunningTargetBloc(),
      expect: () => [],
    );

    blocTest(
      'emits speed when UpdateSpeedEvent is added',
      build: () => RunningTargetBloc(),
      act: (bloc) => bloc.add(UpdateSpeedEvent(14.3.toDouble())),
      expect: () => createOnInitialState(speed: 14.3.toDouble()),
    );

    blocTest(
      'emits speedunit MPH when UpdateSpeedUnitEvent is added',
      build: () => RunningTargetBloc(),
      act: (bloc) => bloc.add(UpdateSpeedUnitEvent(SpeedUnit.MPH)),
      expect: () => createOnInitialState(speedUnit: SpeedUnit.MPH),
    );

    blocTest(
      'emits speedunit KMH when UpdateSpeedUnitEvent is added',
      build: () => RunningTargetBloc(),
      act: (bloc) => bloc.add(UpdateSpeedUnitEvent(SpeedUnit.KMH)),
      expect: () => createOnInitialState(speedUnit: SpeedUnit.KMH),
    );

    blocTest(
      'emits distance when UpdateDistanceEvent is added',
      build: () => RunningTargetBloc(),
      act: (bloc) => bloc.add(UpdateDistanceEvent(5.toDouble())),
      expect: () => createOnInitialState(distance: 5.toDouble()),
    );

    blocTest(
      'emits distanceunit KM when UpdateDistanceUnitEvent is added',
      build: () => RunningTargetBloc(),
      act: (bloc) => bloc.add(UpdateDistanceUnitEvent(DistanceUnit.KM)),
      expect: () => createOnInitialState(distanceUnit: DistanceUnit.KM),
    );

    blocTest(
      'emits distanceunit mile when UpdateDistanceUnitEvent is added',
      build: () => RunningTargetBloc(),
      act: (bloc) => bloc.add(UpdateDistanceUnitEvent(DistanceUnit.M)),
      expect: () => createOnInitialState(distanceUnit: DistanceUnit.M),
    );

    blocTest(
      'emits running time when UpdateSpeedUnitEvent is added',
      build: () => RunningTargetBloc(),
      act: (bloc) => bloc.add(UpdateRunningTimeEvent(RunningTime(10, 10, 10))),
      expect: () => createOnInitialState(time: RunningTime(10, 10, 10)),
    );
  });
}
