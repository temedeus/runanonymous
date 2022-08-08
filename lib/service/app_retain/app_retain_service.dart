import 'package:flutter/services.dart';

class AppRetainService {
  static final _channel =
      const MethodChannel('com.example.simplerunner/app_retain');

  static const String SEND_TO_FOREGROUND = "sendToBackground";
  static const String START_SERVICE = "startService";
  static const String STOP_SERVICE = "stopService";

  void startService() {
    _channel.invokeMethod(START_SERVICE);
  }

  void stopService() {
    _channel.invokeMethod(STOP_SERVICE);
  }

  void sendToForeground() {
    _channel.invokeMethod(SEND_TO_FOREGROUND);
  }
}
