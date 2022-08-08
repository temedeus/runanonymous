import 'location_facade.dart';

class LocationServiceInterface {
  LocationFacade createLocation() {
    return LocationFacade();
  }
}
