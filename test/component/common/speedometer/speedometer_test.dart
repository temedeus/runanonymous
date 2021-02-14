import 'package:flutter_test/flutter_test.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';
import 'package:runanonymous/component/speedometer/speedometer.dart';

void main() {
  testWidgets('Speedometer is pumped', (WidgetTester tester) async {
    await tester.pumpWidget(Speedometer(13.0, SpeedUnit.KMH));
    final speedometerFinder = find.byType(Speedometer);
    expect((speedometerFinder), findsOneWidget);
  });
}
