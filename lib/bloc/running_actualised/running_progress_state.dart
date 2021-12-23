import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class RunningProgressState extends Equatable {
  final List averageSpeeds;
  final double speedSum;
  final double distanceTravelledTotal;
  final double distanceTravelled;
  final double distanceDataPointCounter;

  RunningProgressState(
      {this.averageSpeeds,
      this.speedSum,
      this.distanceTravelled,
      this.distanceTravelledTotal,
      this.distanceDataPointCounter});

  @override
  List<Object> get props => [
        averageSpeeds,
        speedSum,
        distanceTravelled,
        distanceTravelledTotal,
        distanceDataPointCounter,
      ];
}
