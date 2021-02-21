import 'package:get_it/get_it.dart';
import 'package:runanonymous/service/app_retain_service.dart';
import 'package:runanonymous/service/app_retain_service_interface.dart';
import 'package:runanonymous/service/audio_service.dart';
import 'package:runanonymous/service/audio_service_interface.dart';
import 'package:runanonymous/service/location_service.dart';
import 'package:runanonymous/service/location_service_interface.dart';
import 'package:runanonymous/service/timer_service.dart';
import 'package:runanonymous/service/timer_service_interface.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<AppRetainServiceInterface>(
      () => AppRetainService());
  locator.registerLazySingleton<AudioServiceInterface>(() => AudioService());
  locator
      .registerLazySingleton<LocationServiceInterface>(() => LocationService());
  locator.registerLazySingleton<TimerServiceInterface>(() => TimerService());
}