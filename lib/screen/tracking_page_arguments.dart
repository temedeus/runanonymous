import 'package:runanonymous/bloc/running_target/running_time.dart';
import 'package:runanonymous/common/unit/distance_unit.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';

class TrackingPageArguments {
  final SpeedUnit speedUnitClear;
  final DistanceUnit distanceUnit;
  final double targetDistance;
  final double targetSpeed;
  final RunningTime targetTime;

  TrackingPageArguments(this.speedUnitClear, this.distanceUnit,
      this.targetDistance, this.targetSpeed, this.targetTime);
}
