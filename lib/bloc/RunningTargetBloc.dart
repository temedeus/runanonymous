/// The [dart:async] is necessary for using streams
import 'dart:async';

import 'package:runanonymous/bloc/AbstractBloc.dart';
import 'package:runanonymous/model/RunningTarget.dart';

class RunningTargetBloc extends AbstractBloc {
  final _runningTargetStreamController = StreamController.broadcast();

  Stream get getStream => _runningTargetStreamController.stream;
  RunningTarget get getRunningTarget => _runningTarget;

  RunningTarget _runningTarget = new RunningTarget();

  void updateRunningTarget(runningTarget) {
    this._runningTarget = runningTarget;
    _runningTargetStreamController.sink.add(_runningTarget);
  }

  @override
  void dispose() {
    _runningTargetStreamController.close();
  }
}

final runningTargetBloc = RunningTargetBloc();
