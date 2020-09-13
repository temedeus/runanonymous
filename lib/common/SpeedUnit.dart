enum SpeedUnit { KMH, MPH }

extension SpeedUnitClear on SpeedUnit {
  String get unit {
    switch (this) {
      case SpeedUnit.KMH:
        return "Kmh";
      case SpeedUnit.MPH:
        return "Mph";
      default:
        return null;
    }
  }
}
