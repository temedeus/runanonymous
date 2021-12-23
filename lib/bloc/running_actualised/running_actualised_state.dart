import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class RunningActualisedState extends Equatable {
  final List averageSpeeds;
  final double speedList;
  final double distanceTravelledTotal;
  final double distanceTravelled;
  final double distanceDataPointCounter;

  RunningActualisedState(
      {this.averageSpeeds,
      this.speedList,
      this.distanceTravelled,
      this.distanceTravelledTotal,
      this.distanceDataPointCounter});

  @override
  List<Object> get props => [
        averageSpeeds,
        speedList,
        distanceTravelled,
        distanceTravelledTotal,
        distanceDataPointCounter,
      ];
}
