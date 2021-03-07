import 'package:runanonymous/service/location/location_interface.dart';
import 'package:runanonymous/service/location/location_service_interface.dart';

import 'LocationFacadeMock.dart';

class LocationServiceMock implements LocationServiceInterface {
  @override
  LocationInterface createLocation() {
    return LocationFacadeMock();
  }
}
