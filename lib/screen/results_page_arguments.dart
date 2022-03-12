import 'package:runanonymous/bloc/running_progress/speed_average_entry.dart';
import 'package:runanonymous/common/unit/distance_unit.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';

class ResultsPageArguments {
  final SpeedUnit speedUnitClear;
  final DistanceUnit distanceUnit;
  final List<SpeedAverageEntry> averageSpeeds;

  ResultsPageArguments(
      this.averageSpeeds, this.speedUnitClear, this.distanceUnit);
}
