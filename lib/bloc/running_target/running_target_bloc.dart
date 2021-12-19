/// The [dart:async] is necessary for using streams
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runanonymous/bloc/running_target/running_target_state.dart';
import 'package:runanonymous/bloc/running_target/running_time.dart';
import 'package:runanonymous/bloc/running_target/running_time_event.dart';
import 'package:runanonymous/common/unit/distance_unit.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';

class RunningTargetBloc
    extends Bloc<AbstractRunningTimeEvent, RunningTargetState> {
  static final RunningTargetState _initialState = RunningTargetState(
    distance: 0,
    time: new RunningTime(0, 0, 0),
    distanceUnit: DistanceUnit.KM,
    speed: 0,
    speedUnit: SpeedUnit.KMH,
  );

  RunningTargetBloc() : super(_initialState) {
    on<UpdateDistanceEvent>((event, emit) =>
        emit(fromOldSettingState(state, distance: event.payload)));
    on<UpdateRunningTimeEvent>(
        (event, emit) => emit(fromOldSettingState(state, time: event.payload)));
    on<UpdateSpeedEvent>((event, emit) =>
        emit(fromOldSettingState(state, speed: event.payload)));
    on<UpdateSpeedUnitEvent>((event, emit) =>
        emit(fromOldSettingState(state, speedUnit: event.payload)));
    on<UpdateDistanceUnitEvent>((event, emit) =>
        emit(fromOldSettingState(state, distanceUnit: event.payload)));
    on<ResetFormEvent>((event, emit) => emit(resetState()));
  }

  RunningTargetState resetState() {
    return _initialState;
  }

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
}
