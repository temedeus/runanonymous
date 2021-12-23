import 'package:flutter/cupertino.dart';
import 'package:runanonymous/bloc/running_actualised/running_progress_datapoint.dart';

@immutable
abstract class RunningActualisedEvent {
  final dynamic payload;

  RunningActualisedEvent(this.payload);
}

class ResetFormEvent extends RunningActualisedEvent {
  ResetFormEvent() : super(null);
}

class UpdateRunningProgressEvent extends RunningActualisedEvent {
  UpdateRunningProgressEvent(RunningProgressDatapoint payload) : super(payload);
}
