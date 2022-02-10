/// Different routes used in app.
enum RouteMapping { HOME, TRACKING, RESULTS }

/// Starting view.
const INITIAL_ROUTE = RouteMapping.HOME;

/// Path definitions for each route.
extension RoutePath on RouteMapping {
  String get path {
    switch (this) {
      case RouteMapping.HOME:
        return "/";
      case RouteMapping.TRACKING:
        return "/tracking";
      case RouteMapping.RESULTS:
        return "/results";
      default:
        return null;
    }
  }
}
