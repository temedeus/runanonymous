import 'package:runanonymous/model/location_interface.dart';
import 'package:runanonymous/service/location_service_interface.dart';

import 'LocationFacadeMock.dart';

class LocationServiceMock implements LocationServiceInterface {
  @override
  LocationInterface createLocation() {
    return LocationFacadeMock();
  }
}
