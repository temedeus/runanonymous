enum DistanceUnit { KM, M }

extension DistanceUnitClear on DistanceUnit {
  String get unit {
    switch (this) {
      case DistanceUnit.KM:
        return "km";
      case DistanceUnit.M:
        return "miles";
      default:
        return null;
    }
  }

  String toShortString() {
    return this.toString().split('.').last;
  }
}

class DistanceUnitHelper {
  static DistanceUnit valueOf(String value) {
    for (DistanceUnit distanceUnit in DistanceUnit.values) {
      if (distanceUnit.unit == value) return distanceUnit;
    }

    return null;
  }
}
