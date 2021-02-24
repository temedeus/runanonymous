import 'package:runanonymous/model/location_facade.dart';
import 'package:runanonymous/model/location_interface.dart';
import 'package:runanonymous/service/location_service_interface.dart';

class LocationService implements LocationServiceInterface {
  @override
  LocationInterface createLocation() {
    return LocationFacade();
  }
}
