enum SpeedUnit { KMH, MPH }

// TODO: return localization key
extension SpeedUnitClear on SpeedUnit {
  String get unit {
    switch (this) {
      case SpeedUnit.KMH:
        return "kmh";
      case SpeedUnit.MPH:
        return "mph";
      default:
        return null;
    }
  }

  String toShortString() {
    return this.toString().split('.').last;
  }
}

class SpeedUnitHelper {
  static SpeedUnit valueOf(String value) {
    for (SpeedUnit speedUnit in SpeedUnit.values) {
      if (speedUnit.unit == value) return speedUnit;
    }

    return null;
  }
}
