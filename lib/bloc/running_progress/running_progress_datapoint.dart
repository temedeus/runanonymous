import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class RunningProgressDatapoint extends Equatable {
  final double speed;
  final double distanceToPreviousLocation;

  RunningProgressDatapoint(this.speed, this.distanceToPreviousLocation);

  @override
  List<Object> get props => [speed, distanceToPreviousLocation];
}
