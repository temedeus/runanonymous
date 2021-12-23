import 'package:bloc/bloc.dart';
import 'package:runanonymous/bloc/running_actualised/running_progress_event.dart';
import 'package:runanonymous/bloc/running_actualised/running_progress_state.dart';

class RunningProgressBloc
    extends Bloc<RunningActualisedEvent, RunningProgressState> {
  static final RunningProgressState _initialState = RunningProgressState(
      averageSpeeds: [],
      speedSum: 0,
      distanceTravelled: 0,
      distanceTravelledTotal: 0,
      distanceDataPointCounter: 0);

  RunningProgressBloc(RunningProgressState initialState) : super(initialState);

  RunningProgressState resetState() {
    return _initialState;
  }

  RunningProgressState fromOldSettingState(RunningProgressState oldState,
      {averages,
      speedList,
      distanceTravelled,
      distanceTravelledTotal,
      distanceDataPointCounter}) {
    return RunningProgressState(
        averageSpeeds: averages ?? oldState.averageSpeeds,
        speedSum: speedList ?? oldState.speedSum,
        distanceTravelled: distanceTravelled ?? oldState.distanceTravelled,
        distanceTravelledTotal:
            distanceTravelledTotal ?? oldState.distanceTravelledTotal,
        distanceDataPointCounter:
            distanceDataPointCounter ?? oldState.distanceDataPointCounter);
  }
}
