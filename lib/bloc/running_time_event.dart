import 'package:flutter/cupertino.dart';

@immutable
abstract class AbstractRunningTimeEvent {
  final dynamic payload;
  AbstractRunningTimeEvent(this.payload);
}

class UpdateRunningTimeEvent extends AbstractRunningTimeEvent {
  UpdateRunningTimeEvent(payload) : super(payload);
}

class UpdateDistanceEvent extends AbstractRunningTimeEvent {
  UpdateDistanceEvent(payload) : super(payload);
}

class UpdateDistanceUnitEvent extends AbstractRunningTimeEvent {
  UpdateDistanceUnitEvent(payload) : super(payload);
}

class UpdateSpeedEvent extends AbstractRunningTimeEvent {
  UpdateSpeedEvent(payload) : super(payload);
}

class UpdateSpeedUnitEvent extends AbstractRunningTimeEvent {
  UpdateSpeedUnitEvent(payload) : super(payload);
}
