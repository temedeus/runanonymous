import 'package:runanonymous/common/DistanceUnit.dart';
import 'package:runanonymous/common/SpeedUnit.dart';
import 'package:runanonymous/model/RunningTime.dart';

/// Model for running target specifications.
class RunningTarget {
  int distance;
  DistanceUnit distanceUnit;
  RunningTime time;
  int speed;
  SpeedUnit speedUnit;
}
