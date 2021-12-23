import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class RunningActualisedDatapoint extends Equatable {
  final double speed;
  final double distanceToPreviousLocation;

  RunningActualisedDatapoint(this.speed, this.distanceToPreviousLocation);

  @override
  List<Object> get props => [speed, distanceToPreviousLocation];
}
