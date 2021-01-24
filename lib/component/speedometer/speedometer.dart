import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:runanonymous/common/speed_status.dart';
import 'package:runanonymous/common/speed_unit.dart';
import 'package:runanonymous/component/common/app_retain_widget.dart';
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
  final double targetSpeed;

  Location _location;
  LocationData _currentLocation;
  PermissionStatus _permissionGranted;
  Timer _timer;
  StreamSubscription<LocationData> _locationSubscription;
  SpeedStatus _speedStatus = SpeedStatus.SLOW;
  AudioCache _audioCache = AudioCache();

  static const double MS_TO_MPH_CONVERSION_RATE = 2.236936;
  static const double MS_TO_KMH_CONVERSION_RATE = 3.6;
  static const double LOWER_THRESHOLD = 0.9;
  static const double UPPER_THRESHOLD = 1.1;
  static const double _MINIMUM_SPEED_TO_TRACK = 0.5;

  static const String SOUND_TOO_SLOW = "sounds/too_slow_whip.wav";
  static const String SOUND_TOO_FAST = "sounds/too_fast_clink.wav";
  static const _channel =
      const MethodChannel('com.example.simplerunner/app_retain');

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
    //  Screen.keepOn(true);
    _channel.invokeMethod('startService');
  }

  @override
  Widget build(BuildContext context) {
    return _currentLocation == null
        ? CircularProgressIndicator()
        : AppRetainWidget(
            child: SpeedText(_currentLocation.speed * _conversionRate,
                _speedStatus, speedUnit),
          );
  }

  void _initTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentLocation != null) {
        double convertedCurrentSpeed =
            _currentLocation.speed * _conversionRate ?? 0;
        debugPrint("Monitoring running speed...");
        if (convertedCurrentSpeed > _MINIMUM_SPEED_TO_TRACK) {
          _speedStatus = SpeedStatus.ON_TIME;

          if (convertedCurrentSpeed < targetSpeed * LOWER_THRESHOLD) {
            _speedStatus = SpeedStatus.SLOW;
            _playLocalSound(SOUND_TOO_SLOW);
            debugPrint(
                "You're running too slow! Current: $convertedCurrentSpeed target: $targetSpeed");
          }

          if (convertedCurrentSpeed > targetSpeed * UPPER_THRESHOLD) {
            _speedStatus = SpeedStatus.FAST;
            _playLocalSound(SOUND_TOO_FAST);
            debugPrint(
                "You're running too fast!: $convertedCurrentSpeed target: $targetSpeed");
          }
        }
      }
    });
  }

  _playLocalSound(sound) async {
    await _audioCache.play(sound);
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
    //   Screen.keepOn(false);
    _audioCache.clearCache();
    _channel.invokeMethod('stopService');
    super.dispose();
  }
}
