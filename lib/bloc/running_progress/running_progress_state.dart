import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class RunningProgressState extends Equatable {
  final Map<double, double> averageSpeeds;
  final double speedSumDataPoint;
  final double speedSumTotal;
  final double distanceTravelled;
  final int distanceDataPointCounter;
  final double targetDistance;

  RunningProgressState({
    this.averageSpeeds,
    this.speedSumDataPoint,
    this.distanceTravelled,
    this.speedSumTotal,
    this.distanceDataPointCounter,
    this.targetDistance,
  });

  @override
  List<Object> get props => [
        averageSpeeds,
        speedSumDataPoint,
        distanceTravelled,
        speedSumTotal,
        distanceDataPointCounter,
        targetDistance,
      ];

  @override
  String toString() {
    return props.join(',');
  }
}
