import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';
import 'package:runanonymous/component/speedometer/speedometer.dart';
import 'package:runanonymous/service/app_retain_service_interface.dart';
import 'package:runanonymous/service/audio_service_interface.dart';
import 'package:runanonymous/service/location_service_interface.dart';
import 'package:runanonymous/service/timer_service_interface.dart';

import 'mocks/AppRetainServiceMock.dart';
import 'mocks/AudioServiceInterfaceMock.dart';
import 'mocks/LocationServiceMock.dart';
import 'mocks/TimerServiceMock.dart';

void main() {
  GetIt locator = GetIt.instance;

  setUp(() {
    locator.registerLazySingleton<AppRetainServiceInterface>(
        () => AppRetainServiceMock());
    locator
        .registerLazySingleton<AudioServiceInterface>(() => AudioServiceMock());
    locator
        .registerLazySingleton<TimerServiceInterface>(() => TimerServiceMock());
    locator.registerLazySingleton<LocationServiceInterface>(
        () => LocationServiceMock());
  });

  testWidgets('Speedometer is pumped', (WidgetTester tester) async {
    await tester.pumpWidget(Speedometer(13.0, SpeedUnit.KMH));
    final speedometerFinder = find.byType(Speedometer);
    expect((speedometerFinder), findsOneWidget);
  });
}