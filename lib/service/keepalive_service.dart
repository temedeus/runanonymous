import 'package:flutter/services.dart';
import 'package:runanonymous/service/keepalive_service_interface.dart';

class KeepAliveService implements KeepAliveServiceInterface {
  static const _channel =
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
