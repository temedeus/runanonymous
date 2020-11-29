import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:runanonymous/common/speed_status.dart';
import 'package:runanonymous/common/speed_unit.dart';
import 'package:runanonymous/component/speedometer/speed_text.dart';

class Speedometer extends StatefulWidget {
  final double targetSpeed;
  final SpeedUnit speedUnit;

  Speedometer(this.targetSpeed, this.speedUnit);

  @override
  _SpeedometerState createState() => _SpeedometerState(targetSpeed, speedUnit);
}

class _SpeedometerState extends State<Speedometer> {
  _SpeedometerState(this.targetSpeed, this.speedUnit);

  final SpeedUnit speedUnit;
  Location _location;
  LocationData _currentLocation;
  PermissionStatus _permissionGranted;
  Timer _timer;
  StreamSubscription<LocationData> _locationSubscription;
  SpeedStatus _speedStatus = SpeedStatus.SLOW;
  final double targetSpeed;

  static const double MS_TO_MPH_CONVERSION_RATE = 2.236936;
  static const double MS_TO_KMH_CONVERSION_RATE = 3.6;
  static const double LOWER_THRESHOLD = 0.5;
  static const double UPPER_THRESHOLD = 1.5;
  static const double _MINIMUM_SPEED_TO_TRACK = 0.5;

  double get _conversionRate {
    switch (speedUnit) {
      case SpeedUnit.KMH:
        return MS_TO_KMH_CONVERSION_RATE;
      case SpeedUnit.MPH:
        return MS_TO_MPH_CONVERSION_RATE;
      default:
        return 1;
    }
  }

  @override
  void initState() {
    super.initState();
    _ensureLocationAvailable();
    _initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return _currentLocation == null
        ? CircularProgressIndicator()
        : SpeedText(
            _currentLocation.speed * _conversionRate, _speedStatus, speedUnit);
  }

  void _initTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentLocation != null &&
          _currentLocation.speed > _MINIMUM_SPEED_TO_TRACK) {
        _speedStatus = SpeedStatus.ON_TIME;

        if (_currentLocation.speed * _conversionRate <
            targetSpeed * LOWER_THRESHOLD) {
          HapticFeedback.heavyImpact();
          _speedStatus = SpeedStatus.SLOW;
          debugPrint(
              "You're running too slow! Current: {$_currentLocation.speed} target: $targetSpeed");
        }

        if (_currentLocation.speed * _conversionRate >
            targetSpeed * UPPER_THRESHOLD) {
          _patternVibrate();
          _speedStatus = SpeedStatus.FAST;
          debugPrint(
              "You're running too fast!: ${_currentLocation.speed} target: $targetSpeed");
        }
      }
    });
  }

  void _ensureLocationAvailable() async {
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

    _locationSubscription = _location.onLocationChanged.listen((event) {
      setState(() {
        _currentLocation = event;
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
