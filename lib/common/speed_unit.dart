enum SpeedUnit { KMH, MPH, MPM, MPK }

extension SpeedUnitClear on SpeedUnit {
  String get unit {
    switch (this) {
      case SpeedUnit.KMH:
        return "Kilometers per hour";
      case SpeedUnit.MPH:
        return "Milers per hour";
      case SpeedUnit.MPM:
        return "Minutes per mile";
      case SpeedUnit.MPK:
        return "Minutes per kilometer";
      default:
        return null;
    }
  }
}
