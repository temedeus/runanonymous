enum SpeedUnit { KMH, MPH, MPM, MPK }

// TODO: return localization key
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

  String toShortString() {
    return this.toString().split('.').last;
  }
}

class SpeedUnitHelper {
  static SpeedUnit valueOf(String value) {
    for (SpeedUnit speedUnit in SpeedUnit.values) {
      if (speedUnit.toShortString() == value) return speedUnit;
    }

    return null;
  }

  static get unitValues {
    List<String> items = [];
    for (SpeedUnit speedUnit in SpeedUnit.values) {
      items.add(speedUnit.unit);
    }

    return items;
  }
}
