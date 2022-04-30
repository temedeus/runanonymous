import 'package:bloc/bloc.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_datapoint.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_event.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_state.dart';

class RunningProgressBloc
    extends Bloc<RunningProgressEvent, RunningProgressState> {
  static final RunningProgressState _initialState = RunningProgressState(
      distanceTravelled: 0,
      speedSumTotal: 0,
      distanceDataPointCounter: 0,
      targetDistance: 0,
      averageSpeed: 0);

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
    distanceTravelled,
    speedSumTotal,
    distanceDataPointCounter,
    targetDistance,
    averageSpeed,
  }) {
    return RunningProgressState(
        distanceTravelled: distanceTravelled ?? oldState.distanceTravelled,
        speedSumTotal: speedSumTotal ?? oldState.speedSumTotal,
        distanceDataPointCounter:
            distanceDataPointCounter ?? oldState.distanceDataPointCounter,
        targetDistance: targetDistance ?? oldState.targetDistance,
        averageSpeed: averageSpeed ?? oldState.averageSpeed);
  }

  RunningProgressState updateSpeedDataPoint(RunningProgressState oldState,
      RunningProgressDatapoint runningProgressDataPoint) {
    var distanceDataPointCounter = oldState.distanceDataPointCounter + 1;
    var distanceTravelled = oldState.distanceTravelled +
        runningProgressDataPoint.distanceToPreviousLocation;
    var speedSumTotal = oldState.speedSumTotal + runningProgressDataPoint.speed;

    var averageSpeed = speedSumTotal / distanceDataPointCounter;

    return RunningProgressState(
        distanceTravelled: distanceTravelled,
        speedSumTotal: speedSumTotal,
        distanceDataPointCounter: distanceDataPointCounter,
        averageSpeed: averageSpeed,
        targetDistance: oldState.targetDistance);
  }
}
