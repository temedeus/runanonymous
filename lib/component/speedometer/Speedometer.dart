import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:runanonymous/component/speedometer/speed_text.dart';

class Speedometer extends StatefulWidget {
  @override
  _SpeedometerState createState() => _SpeedometerState();
}

class _SpeedometerState extends State<Speedometer> {
  Location location;

  LocationData currentLocation;
  PermissionStatus _permissionGranted;
  Timer _timer;
  StreamSubscription<LocationData> _locationSubscription;

  @override
  void initState() {
    super.initState();
    _ensureLocationAvailable();
    _initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return currentLocation == null
        ? CircularProgressIndicator()
        : SpeedText(currentLocation.speed);
  }

  void _initTimer() {
    _timer = Timer.periodic(new Duration(seconds: 5), (timer) {
      if (currentLocation != null && currentLocation.speed > 0.5) {
        if (currentLocation.speed < 2) {
          HapticFeedback.heavyImpact();
          debugPrint("You're running too slow!");
        }

        if (currentLocation.speed > 6) {
          _patternVibrate();
          debugPrint("You're running too fast!");
        }
      }
    });
  }

  void _ensureLocationAvailable() async {
    location = Location();
    bool _serviceEnabled;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationSubscription = location.onLocationChanged.listen((event) {
      setState(() {
        currentLocation = event;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _locationSubscription.cancel();
    super.dispose();
  }

  _patternVibrate() {
    const SLEEP_DURATION = Duration(milliseconds: 200);
    HapticFeedback.mediumImpact();
    sleep(SLEEP_DURATION);
    HapticFeedback.mediumImpact();
    sleep(SLEEP_DURATION);
    HapticFeedback.mediumImpact();
  }
}
