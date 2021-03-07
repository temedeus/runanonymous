import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:runanonymous/service/location/location_interface.dart';

class LocationFacadeMock implements LocationInterface {
  @override
  void cancelLocationSubscription() {
    // TODO: implement cancelLocationSubscription
  }

  @override
  void ensureLocationAvailable(void Function(LocationData event) onData) {
    // TODO: implement ensureLocationAvailable
  }
}
