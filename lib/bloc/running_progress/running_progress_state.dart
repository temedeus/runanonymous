import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class RunningProgressState extends Equatable {
  final double speedSumTotal;
  final double distanceTravelled;
  final int distanceDataPointCounter;
  final double targetDistance;
  final double averageSpeed;

  RunningProgressState(
      {this.distanceTravelled,
      this.speedSumTotal,
      this.distanceDataPointCounter,
      this.targetDistance,
      this.averageSpeed});

  @override
  List<Object> get props => [
        distanceTravelled,
        speedSumTotal,
        distanceDataPointCounter,
        targetDistance,
        averageSpeed
      ];

  @override
  String toString() {
    return props.join(',');
  }
}
