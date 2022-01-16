import 'package:bloc/bloc.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_datapoint.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_event.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_state.dart';
import 'package:runanonymous/bloc/running_progress/speed_average_entry.dart';

class RunningProgressBloc
    extends Bloc<RunningProgressEvent, RunningProgressState> {
  static final int _maxPoints = 10;
  static final RunningProgressState _initialState = RunningProgressState(
    averageSpeeds: [],
    speedSumDataPoint: 0,
    distanceTravelled: 0,
    speedSumTotal: 0,
    distanceDataPointCounter: 0,
    targetDistance: 0,
  );

  RunningProgressBloc() : super(_initialState) {
    on<ResetFormEvent>((event, emit) => emit(resetState()));
    on<UpdateRunningProgressEvent>(
        (event, emit) => emit(updateSpeedDataPoint(state, event.payload)));
    on<SetTargetDistance>((event, emit) =>
        emit(fromOldSettingState(state, targetDistance: event.payload)));
  }

  RunningProgressState resetState() {
    return _initialState;
  }

  RunningProgressState fromOldSettingState(
    RunningProgressState oldState, {
    averageSpeeds,
    speedSumDataPoint,
    distanceTravelled,
    speedSumTotal,
    distanceDataPointCounter,
    targetDistance,
  }) {
    return RunningProgressState(
      averageSpeeds: averageSpeeds ?? oldState.averageSpeeds,
      speedSumDataPoint: speedSumDataPoint ?? oldState.speedSumDataPoint,
      distanceTravelled: distanceTravelled ?? oldState.distanceTravelled,
      speedSumTotal: speedSumTotal ?? oldState.speedSumTotal,
      distanceDataPointCounter:
          distanceDataPointCounter ?? oldState.distanceDataPointCounter,
      targetDistance: targetDistance ?? oldState.targetDistance,
    );
  }

  RunningProgressState updateSpeedDataPoint(RunningProgressState oldState,
      RunningProgressDatapoint runningProgressDatapoint) {
    var averageSpeeds = oldState.averageSpeeds;
    var distanceDataPointCounter = oldState.distanceDataPointCounter + 1;
    var distanceTravelled = oldState.distanceTravelled +
        runningProgressDatapoint.distanceToPreviousLocation;
    var speedSumDataPoint =
        oldState.speedSumDataPoint + runningProgressDatapoint.speed;
    var speedSumTotal = oldState.speedSumTotal + runningProgressDatapoint.speed;

    // Milestone based on how many data collection points we have and at what point we are currently.
    var milestone = oldState.targetDistance /
        _maxPoints *
        (oldState.averageSpeeds.length + 1);

    if (distanceTravelled >= milestone &&
        averageSpeeds.length < _maxPoints &&
        distanceTravelled <= oldState.targetDistance) {
      averageSpeeds = List.from(oldState.averageSpeeds);
      var speedAverageWithinDataPoint =
          speedSumDataPoint / distanceDataPointCounter;
      averageSpeeds.add(
          SpeedAverageEntry(distanceTravelled, speedAverageWithinDataPoint));
      distanceDataPointCounter = 0;
      speedSumDataPoint = 0;
    }

    return RunningProgressState(
        averageSpeeds: averageSpeeds,
        speedSumDataPoint: speedSumDataPoint,
        distanceTravelled: distanceTravelled,
        speedSumTotal: speedSumTotal,
        distanceDataPointCounter: distanceDataPointCounter,
        targetDistance: oldState.targetDistance);
  }
}
