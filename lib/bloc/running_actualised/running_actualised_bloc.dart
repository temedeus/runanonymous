import 'package:bloc/bloc.dart';
import 'package:runanonymous/bloc/running_actualised/running_actualised_event.dart';
import 'package:runanonymous/bloc/running_actualised/running_actualised_state.dart';

class RunningActualisedBloc
    extends Bloc<RunningActualisedEvent, RunningActualisedState> {
  static final RunningActualisedState _initialState = RunningActualisedState(
      averageSpeeds: [],
      speedList: 0,
      distanceTravelled: 0,
      distanceTravelledTotal: 0,
      distanceDataPointCounter: 0);

  RunningActualisedBloc(RunningActualisedState initialState)
      : super(initialState);

  RunningActualisedState resetState() {
    return _initialState;
  }

  RunningActualisedState fromOldSettingState(RunningActualisedState oldState,
      {averages,
      speedList,
      distanceTravelled,
      distanceTravelledTotal,
      distanceDataPointCounter}) {
    return RunningActualisedState(
        averageSpeeds: averages ?? oldState.averageSpeeds,
        speedList: speedList ?? oldState.speedList,
        distanceTravelled: distanceTravelled ?? oldState.distanceTravelled,
        distanceTravelledTotal:
            distanceTravelledTotal ?? oldState.distanceTravelledTotal,
        distanceDataPointCounter:
            distanceDataPointCounter ?? oldState.distanceDataPointCounter);
  }
}
