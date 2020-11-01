/// The [dart:async] is necessary for using streams
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runanonymous/bloc/running_target_state.dart';
import 'package:runanonymous/bloc/running_time.dart';
import 'package:runanonymous/bloc/running_time_event.dart';
import 'package:runanonymous/common/distance_unit.dart';
import 'package:runanonymous/common/speed_unit.dart';

class RunningTargetBloc
    extends Bloc<AbstractRunningTimeEvent, RunningTargetState> {
  static final RunningTargetState _initialState = RunningTargetState(
    distance: null,
    time: new RunningTime(),
    distanceUnit: DistanceUnit.KM,
    speed: null,
    speedUnit: SpeedUnit.KMH,
  );

  RunningTargetBloc() : super(_initialState);

  RunningTargetState fromOldSettingState(
    RunningTargetState oldState, {
    distance,
    distanceUnit,
    time,
    speed,
    speedUnit,
  }) {
    var newDistance = distance ?? oldState.distance;
    RunningTime newTime = time ?? oldState.time;
    double newSpeed = (newDistance != null && !newTime.empty)
        ? calculateNewSpeed(double.tryParse(newDistance), newTime)
        : speed ?? oldState.speed;
    return RunningTargetState(
      distance: double.tryParse(newDistance),
      distanceUnit: distanceUnit ?? oldState.distanceUnit,
      time: newTime,
      speed: newSpeed,
      speedUnit: speedUnit ?? oldState.speedUnit,
    );
  }

  double calculateNewSpeed(double distance, RunningTime time) {
    int hour = time.hour ?? 0;
    int minute = time.hour ?? 0;
    int second = time.seconds ?? 0;
    double minutesTime = (hour * 60 + minute + second / 60);
    return (minutesTime > 0) ? distance / minutesTime : 0;
  }

  @override
  Stream<RunningTargetState> mapEventToState(
      AbstractRunningTimeEvent event) async* {
    final _state = state;
    if (event is UpdateDistanceEvent) {
      yield fromOldSettingState(_state, distance: event.payload);
    } else if (event is UpdateRunningTimeEvent) {
      yield fromOldSettingState(_state, time: event.payload);
    } else if (event is UpdateSpeedEvent) {
      yield fromOldSettingState(_state, speed: event.payload);
    } else if (event is UpdateSpeedUnitEvent) {
      yield fromOldSettingState(_state, speedUnit: event.payload);
    } else if (event is UpdateDistanceUnitEvent) {
      yield fromOldSettingState(_state, distanceUnit: event.payload);
    }
  }
}
