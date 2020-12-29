import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:runanonymous/bloc/running_time.dart';
import 'package:runanonymous/common/distance_unit.dart';
import 'package:runanonymous/common/speed_unit.dart';

/// Model for running target specifications.
@immutable
class RunningTargetState extends Equatable {
  final double distance;
  final DistanceUnit distanceUnit;
  final RunningTime time;
  final double speed;
  final SpeedUnit speedUnit;

  RunningTargetState({
    this.distance,
    this.distanceUnit,
    this.time,
    this.speed,
    this.speedUnit,
  });

  @override
  List<Object> get props => [distanceUnit, distance, time, speed, speedUnit];
}
