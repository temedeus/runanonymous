import 'location_facade.dart';
import 'location_interface.dart';
import 'location_service_interface.dart';

class LocationService implements LocationServiceInterface {
  @override
  LocationInterface createLocation() {
    return LocationFacade();
  }
}
