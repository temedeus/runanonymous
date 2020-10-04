import 'package:flutter/cupertino.dart';
import 'package:runanonymous/bloc/running_time.dart';
import 'package:runanonymous/common/distance_unit.dart';
import 'package:runanonymous/common/speed_unit.dart';

/// Model for running target specifications.
@immutable
abstract class AbstractRunningTargetState {
  final int distance;
  final DistanceUnit distanceUnit;
  final RunningTime time;
  final int speed;
  final SpeedUnit speedUnit;

  AbstractRunningTargetState({
    this.distance,
    this.distanceUnit,
    this.time,
    this.speed,
    this.speedUnit,
  });
}

class RunningTargetState extends AbstractRunningTargetState {
  RunningTargetState({
    int distance,
    DistanceUnit distanceUnit,
    RunningTime time,
    int speed,
    SpeedUnit speedUnit,
  }) : super(
            distance: distance,
            distanceUnit: distanceUnit,
            time: time,
            speed: speed,
            speedUnit: speedUnit);
}
