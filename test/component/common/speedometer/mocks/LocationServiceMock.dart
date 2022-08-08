import 'package:runanonymous/service/location/location_facade.dart';
import 'package:runanonymous/service/location/location_service_interface.dart';

import 'LocationFacadeMock.dart';

class LocationServiceMock implements LocationServiceInterface {
  @override
  LocationFacade createLocation() {
    return LocationFacadeMock();
  }
}
