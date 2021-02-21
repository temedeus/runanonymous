import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:runanonymous/common/constants.dart';
import 'package:runanonymous/common/unit/speed_status.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';
import 'package:runanonymous/component/common/app_retain_widget.dart';
import 'package:runanonymous/component/speedometer/speed_text.dart';
import 'package:runanonymous/model/audio_player_interface.dart';
import 'package:runanonymous/model/location_interface.dart';
import 'package:runanonymous/model/timer_interface.dart';
import 'package:runanonymous/service/app_retain_service_interface.dart';
import 'package:runanonymous/service/audio_service_interface.dart';
import 'package:runanonymous/service/location_service_interface.dart';
import 'package:runanonymous/service/service_locator.dart';
import 'package:runanonymous/service/timer_service_interface.dart';

class Speedometer extends StatefulWidget {
  final double targetSpeed;
  final SpeedUnit speedUnit;

  Speedometer(this.targetSpeed, this.speedUnit);

  @override
  _SpeedometerState createState() => _SpeedometerState(targetSpeed, speedUnit);
}

class _SpeedometerState extends State<Speedometer> {
  final SpeedUnit speedUnit;
  final double targetSpeed;

  final AppRetainServiceInterface _appRetainServiceInterface =
      locator<AppRetainServiceInterface>();
  final AudioServiceInterface _audioService = locator<AudioServiceInterface>();
  final LocationServiceInterface _locationService =
      locator<LocationServiceInterface>();
  final TimerServiceInterface _timerService = locator<TimerServiceInterface>();

  Location _location;
  LocationData _currentLocation;
  PermissionStatus _permissionGranted;
  StreamSubscription<LocationData> _locationSubscription;
  SpeedStatus _speedStatus = SpeedStatus.SLOW;
  AudioPlayerInterface _audioPlayerFacade;
  TimerInterface _timerFacade;
  LocationInterface _locationFacade;

  static const String SOUND_TOO_SLOW = "sounds/faster.wav";
  static const String SOUND_TOO_FAST = "sounds/slowdown.wav";

  _SpeedometerState(this.targetSpeed, this.speedUnit) {
    _audioPlayerFacade = _audioService.getAudioPlayer();
  }

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
    _appRetainServiceInterface.startService();
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
    var callback = () {
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
    };
    _timerFacade = _timerService.provideTimer(callback);
  }

  double _convertedSpeed() {
    return _currentLocation.speed * _conversionRate ?? 0;
  }

  _playLocalSound(sound) async {
    await _audioPlayerFacade.playSound(sound);
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
    _timerFacade.stopTimer();
    if (_locationSubscription != null) _locationSubscription.cancel();
    //   Screen.keepOn(false);
    _audioPlayerFacade.clear();
    _appRetainServiceInterface.stopService();
    super.dispose();
  }
}
