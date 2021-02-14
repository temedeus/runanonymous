import 'package:get_it/get_it.dart';
import 'package:runanonymous/service/keepalive_service.dart';
import 'package:runanonymous/service/keepalive_service_interface.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<KeepAliveServiceInterface>(
      () => KeepAliveService());
}
