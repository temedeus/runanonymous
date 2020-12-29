import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class RunningTime extends Equatable {
  final int hour;
  final int minute;
  final int seconds;

  bool get empty {
    return hour == null && minute == null && seconds == null;
  }

  RunningTime(this.hour, this.minute, this.seconds);

  @override
  List<Object> get props => [hour, minute, seconds];
}
