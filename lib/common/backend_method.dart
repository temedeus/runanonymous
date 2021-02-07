enum ServiceMethod { SEND_TO_FOREGROUND, START_SERVICE, STOP_SERVICE }

/// Path definitions for each route.
extension ServiceMethodExtension on ServiceMethod {
  String get method {
    switch (this) {
      case ServiceMethod.SEND_TO_FOREGROUND:
        return "sendToBackground";
      case ServiceMethod.START_SERVICE:
        return "startService";
      case ServiceMethod.STOP_SERVICE:
        return "stopService";
      default:
        return null;
    }
  }
}
