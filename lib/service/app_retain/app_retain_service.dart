import 'package:flutter/services.dart';

import 'app_retain_service_interface.dart';

class AppRetainService implements AppRetainServiceInterface {
  static final _channel =
      const MethodChannel('com.example.simplerunner/app_retain');

  static const String SEND_TO_FOREGROUND = "sendToBackground";
  static const String START_SERVICE = "startService";
  static const String STOP_SERVICE = "stopService";

  @override
  void startService() {
    _channel.invokeMethod(START_SERVICE);
  }

  @override
  void stopService() {
    _channel.invokeMethod(STOP_SERVICE);
  }

  @override
  void sendToForeground() {
    _channel.invokeMethod(SEND_TO_FOREGROUND);
  }
}
