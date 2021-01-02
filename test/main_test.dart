import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:runanonymous/main.dart';

void main() {
  testWidgets('RunanonymousApp has a MaterialApp', (WidgetTester tester) async {
    await tester.pumpWidget(RunanonymousApp());
    final materialAppFinder = find.byType(MaterialApp);
    expect((materialAppFinder), findsOneWidget);
  });
}
