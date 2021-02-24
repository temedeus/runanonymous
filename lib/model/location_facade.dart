import 'dart:async';

import 'package:location/location.dart';
import 'package:runanonymous/model/location_interface.dart';

class LocationFacade implements LocationInterface {
  Location _location;

  PermissionStatus _permissionGranted;
  StreamSubscription<LocationData> _locationSubscription;

  @override
  void ensureLocationAvailable(locationChangedListener) async {
    _location = Location();
    bool _serviceEnabled;
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationSubscription =
        _location.onLocationChanged.listen(locationChangedListener);
  }

  @override
  void cancelLocationSubscription() {
    if (_locationSubscription != null) _locationSubscription.cancel();
  }
}
