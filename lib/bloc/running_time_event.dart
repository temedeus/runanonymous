import 'package:flutter/cupertino.dart';
import 'package:runanonymous/bloc/running_time.dart';
import 'package:runanonymous/common/unit/distance_unit.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';

@immutable
abstract class AbstractRunningTimeEvent {
  final dynamic payload;
  AbstractRunningTimeEvent(this.payload);
}

class ResetFormEvent extends AbstractRunningTimeEvent {
  ResetFormEvent() : super(null);
}

class UpdateRunningTimeEvent extends AbstractRunningTimeEvent {
  UpdateRunningTimeEvent(RunningTime payload) : super(payload);
}

class UpdateDistanceEvent extends AbstractRunningTimeEvent {
  UpdateDistanceEvent(double payload) : super(payload);
}

class UpdateDistanceUnitEvent extends AbstractRunningTimeEvent {
  UpdateDistanceUnitEvent(DistanceUnit payload) : super(payload);
}

class UpdateSpeedEvent extends AbstractRunningTimeEvent {
  UpdateSpeedEvent(double payload) : super(payload);
}

class UpdateSpeedUnitEvent extends AbstractRunningTimeEvent {
  UpdateSpeedUnitEvent(SpeedUnit payload) : super(payload);
}
