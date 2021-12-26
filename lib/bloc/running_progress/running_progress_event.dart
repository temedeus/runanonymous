import 'package:flutter/cupertino.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_datapoint.dart';

@immutable
abstract class RunningProgressEvent {
  final dynamic payload;

  RunningProgressEvent(this.payload);
}

class ResetFormEvent extends RunningProgressEvent {
  ResetFormEvent() : super(null);
}

// Expecting to operate with correct units as source is either RunningTargetBloc or Location object itself.
class UpdateRunningProgressEvent extends RunningProgressEvent {
  UpdateRunningProgressEvent(RunningProgressDatapoint payload) : super(payload);
}

// Expecting to operate with correct units as source is either RunningTargetBloc or Location object itself.
class SetTargetDistance extends RunningProgressEvent {
  SetTargetDistance(double payload) : super(payload);
}
