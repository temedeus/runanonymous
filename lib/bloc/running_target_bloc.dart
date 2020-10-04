/// The [dart:async] is necessary for using streams
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runanonymous/bloc/running_target_state.dart';
import 'package:runanonymous/bloc/running_time.dart';
import 'package:runanonymous/bloc/running_time_event.dart';
import 'package:runanonymous/common/distance_unit.dart';
import 'package:runanonymous/common/speed_unit.dart';

class RunningTargetBloc
    extends Bloc<AbstractRunningTimeEvent, AbstractRunningTargetState> {
  static final RunningTargetState _initialState = RunningTargetState(
    distance: null,
    time: new RunningTime(),
    distanceUnit: DistanceUnit.KM,
    speed: 666,
    speedUnit: SpeedUnit.KMH,
  );

  RunningTargetBloc() : super(_initialState);

  RunningTargetState fromOldSettingState(
    AbstractRunningTargetState oldState, {
    distance,
    distanceUnit,
    time,
    speed,
    speedUnit,
  }) {
    return RunningTargetState(
      distance: distance ?? oldState.distance,
      distanceUnit: distanceUnit ?? oldState.distanceUnit,
      time: time ?? oldState.time,
      speed: speed ?? oldState.speed,
      speedUnit: speedUnit ?? oldState.speedUnit,
    );
  }

  @override
  Stream<AbstractRunningTargetState> mapEventToState(
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
