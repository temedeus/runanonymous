import 'package:get_it/get_it.dart';
import 'package:runanonymous/service/timer/timer_service.dart';
import 'package:runanonymous/service/timer/timer_service_interface.dart';

import 'app_retain/app_retain_service.dart';
import 'app_retain/app_retain_service_interface.dart';
import 'location/location_service.dart';
import 'location/location_service_interface.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<AppRetainServiceInterface>(
      () => AppRetainService());
  locator
      .registerLazySingleton<LocationServiceInterface>(() => LocationService());
  locator.registerLazySingleton<TimerServiceInterface>(() => TimerService());
}
