/// Different routes used in app.
enum RouteMapping { HOME, TRACKING }

/// Path definitions for each route.
extension RoutePath on RouteMapping {
  String get path {
    switch (this) {
      case RouteMapping.HOME:
        return "/";
      case RouteMapping.TRACKING:
        return "/tracking";
      default:
        return null;
    }
  }
}
