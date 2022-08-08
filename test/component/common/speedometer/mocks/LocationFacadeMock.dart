import 'package:runanonymous/service/location/location_facade.dart';

class LocationFacadeMock implements LocationFacade {
  @override
  void cancelLocationSubscription() {}

  @override
  void ensureLocationAvailable(locationChangedListener) {}
}
