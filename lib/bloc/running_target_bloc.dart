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
    distance: 0,
    time: new RunningTime(0, 0, 0),
    distanceUnit: DistanceUnit.KM,
    speed: 0,
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
    double newDistance = distance ?? oldState.distance;
    RunningTime newTime = time ?? oldState.time;
    double newSpeed = (newDistance != null && !newTime.empty)
        ? calculateNewSpeed(newDistance, newTime)
        : speed ?? oldState.speed;
    return RunningTargetState(
      distance: newDistance,
      distanceUnit: distanceUnit ?? oldState.distanceUnit,
      time: newTime,
      speed: newSpeed,
      speedUnit: speedUnit ?? oldState.speedUnit,
    );
  }

  /// Speed in unit{km|m}/hour.
  double calculateNewSpeed(double distance, RunningTime time) {
    int hour = time.hour ?? 0;
    int minute = time.minute ?? 0;
    int second = time.seconds ?? 0;
    double hourTime = (hour + minute / 60 + second / 3600);
    return (hourTime > 0) ? distance / hourTime : 0;
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
