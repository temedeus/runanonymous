import 'package:flutter_test/flutter_test.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';

void main() {
  group("speed unit helper test", () {
    test("speed unit helper finds value", () {
      SpeedUnit unit = SpeedUnitHelper.valueOf("kmh");
      expect(unit, SpeedUnit.KMH);
    });
    test("speed unit helper non-existing value", () {
      SpeedUnit unit = SpeedUnitHelper.valueOf("blaa");
      expect(unit, null);
    });
  });
}
