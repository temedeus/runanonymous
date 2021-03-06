import 'package:flutter/services.dart';

class AppRetainServiceMethod {
  static const SEND_TO_FOREGROUND = "sendToBackground";
  static const START_SERVICE = "startService";
  static const STOP_SERVICE = "stopService";
  static const METHOD_CHANNEL =
      MethodChannel('com.example.simplerunner/app_retain');
}
