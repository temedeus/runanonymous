enum DistanceUnit { KM, M }

extension DistanceUnitClear on DistanceUnit {
  String get unit {
    switch (this) {
      case DistanceUnit.KM:
        return "Km";
      case DistanceUnit.M:
        return "Miles";
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
      if (distanceUnit.toShortString() == value) return distanceUnit;
    }

    return null;
  }
}
