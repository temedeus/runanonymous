import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:runanonymous/common/backend_method.dart';
import 'package:runanonymous/common/constants.dart';
import 'package:runanonymous/common/unit/speed_status.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';
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

  static const String SOUND_TOO_SLOW = "sounds/too_slow_whip.wav";
  static const String SOUND_TOO_FAST = "sounds/too_fast_clink.wav";
  static const _channel =
      const MethodChannel('com.example.simplerunner/app_retain');

  double get _conversionRate {
    switch (speedUnit) {
      case SpeedUnit.KMH:
        return Constants.MS_TO_KMH_CONVERSION_RATE;
      case SpeedUnit.MPH:
        return Constants.MS_TO_MPH_CONVERSION_RATE;
      default:
        return 1;
    }
  }

  @override
  void initState() {
    super.initState();
    _ensureLocationAvailable();
    _initTimer();
    _channel.invokeMethod(ServiceMethod.START_SERVICE.method);
  }

  @override
  Widget build(BuildContext context) {
    return _currentLocation == null
        ? CircularProgressIndicator()
        : AppRetainWidget(
            child: SpeedText(_convertedSpeed(), _speedStatus, speedUnit),
          );
  }

  void _initTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentLocation != null) {
        double convertedCurrentSpeed = _convertedSpeed();
        debugPrint("Monitoring running speed...");
        if (convertedCurrentSpeed > Constants.MINIMUM_SPEED_TO_TRACK) {
          _speedStatus = SpeedStatus.ON_TIME;

          if (convertedCurrentSpeed < targetSpeed * Constants.LOWER_THRESHOLD) {
            _speedStatus = SpeedStatus.SLOW;
            _playLocalSound(SOUND_TOO_SLOW);
            debugPrint(
                "You're running too slow! Current: $convertedCurrentSpeed target: $targetSpeed");
          }

          if (convertedCurrentSpeed > targetSpeed * Constants.UPPER_THRESHOLD) {
            _speedStatus = SpeedStatus.FAST;
            _playLocalSound(SOUND_TOO_FAST);
            debugPrint(
                "You're running too fast!: $convertedCurrentSpeed target: $targetSpeed");
          }
        }
      }
    });
  }

  double _convertedSpeed() {
    return _currentLocation.speed * _conversionRate ?? 0;
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
    if (_locationSubscription != null) _locationSubscription.cancel();
    //   Screen.keepOn(false);
    _audioCache.clearCache();
    _channel.invokeMethod(ServiceMethod.STOP_SERVICE.method);
    super.dispose();
  }
}
