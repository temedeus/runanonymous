/// The [dart:async] is necessary for using streams
import 'dart:async';

import 'package:runanonymous/bloc/AbstractBloc.dart';
import 'package:runanonymous/model/RunningTarget.dart';

class RunningTargetBloc extends AbstractBloc {
  final _runningTargetStreamController = StreamController.broadcast();

  Stream get getStream => _runningTargetStreamController.stream;

  RunningTarget _runningTarget = new RunningTarget();

  get runningTargetStreamController => _runningTargetStreamController;

  void updateSpeed(runningTarget) {
    this._runningTarget = runningTarget;
    _runningTargetStreamController.sink.add(_runningTarget);
  }

  void updateTime(runningTime) {
    this._runningTarget.time = runningTime;

    _runningTargetStreamController.sink.add(_runningTarget);
  }

  void updateDistance(runningTarget) {
    this._runningTarget = runningTarget;
    _runningTargetStreamController.sink.add(_runningTarget);
  }

  void updateRunningTarget(runningTarget) {
    this._runningTarget = runningTarget;
    _runningTargetStreamController.sink.add(_runningTarget);
  }

  @override
  void dispose() {
    _runningTargetStreamController.close();
  }

  @override
  mapEventToState() {
    // TODO: implement mapEventToState
  }
}

final runningTargetBloc = RunningTargetBloc();
