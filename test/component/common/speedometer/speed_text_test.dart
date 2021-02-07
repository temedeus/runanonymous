import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:runanonymous/common/speed_status.dart';
import 'package:runanonymous/common/speed_unit.dart';
import 'package:runanonymous/component/speedometer/speed_text.dart';

void main() {
  testWidgets('SpeedText is present', (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: (SpeedText(13.0, SpeedStatus.ON_TIME, SpeedUnit.KMH))));
    final materialAppFinder = find.byType(SpeedText);
    expect((materialAppFinder), findsOneWidget);
  });

  testWidgets('Text widget is present', (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: (SpeedText(13.0, SpeedStatus.ON_TIME, SpeedUnit.KMH))));
    final textFinder = find.text("fr");

    expect((textFinder), findsOneWidget);
  });
}
