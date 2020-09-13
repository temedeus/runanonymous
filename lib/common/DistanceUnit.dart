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
}
