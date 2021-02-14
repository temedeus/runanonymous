import 'package:flutter_test/flutter_test.dart';

import 'file:///C:/Users/teemu/AndroidStudioProjects/simple_runner/lib/common/unit/distance_unit.dart';

void main() {
  group("distance unit helper test", () {
    test("distance unit helper finds value", () {
      DistanceUnit unit = DistanceUnitHelper.valueOf("km");
      expect(unit, DistanceUnit.KM);
    });
    test("distance unit helper non-existing value", () {
      DistanceUnit unit = DistanceUnitHelper.valueOf("blaa");
      expect(unit, null);
    });
  });
}
