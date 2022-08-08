import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_bloc.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_datapoint.dart';
import 'package:runanonymous/bloc/running_progress/running_progress_event.dart';
import 'package:runanonymous/common/constants.dart';
import 'package:runanonymous/common/unit/speed_status.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';
import 'package:runanonymous/component/common/app_retain_widget.dart';
import 'package:runanonymous/component/speedometer/speed_text.dart';
import 'package:runanonymous/service/app_retain/app_retain_service.dart';
import 'package:runanonymous/service/location/location_facade.dart';
import 'package:runanonymous/service/location/location_service_interface.dart';
import 'package:runanonymous/service/service_locator.dart';
import 'package:runanonymous/service/timer/timer_facade.dart';
import 'package:runanonymous/service/timer/timer_service.dart';

class Speedometer extends StatefulWidget {
  final double targetSpeed;
  final SpeedUnit speedUnit;
  final Stopwatch stopwatch;

  Speedometer(this.targetSpeed, this.speedUnit, this.stopwatch);

  @override
  _SpeedometerState createState() =>
      _SpeedometerState(targetSpeed, speedUnit, stopwatch);
}

class _SpeedometerState extends State<Speedometer> {
  final SpeedUnit speedUnit;
  final double targetSpeed;
  final stopwatch;

  final AppRetainService _appRetainServiceInterface =
      locator<AppRetainService>();
  final LocationServiceInterface _locationService =
      locator<LocationServiceInterface>();
  final TimerServiceInterface _timerService = locator<TimerServiceInterface>();

  LocationFacade _locationFacade;
  LocationData _currentLocation;
  SpeedStatus _speedStatus = SpeedStatus.SLOW;
  TimerFacade _timerFacade;

  double _previousLatitude;
  double _previousLongitude;

  _SpeedometerState(this.targetSpeed, this.speedUnit, this.stopwatch) {
    _locationFacade = _locationService.createLocation();
  }

  @override
  void initState() {
    super.initState();
    _initTimer();
    _locationFacade.ensureLocationAvailable((event) {
      setState(() {
        _currentLocation = event;
        stopwatch.start();
      });
    });
    _appRetainServiceInterface.startService();
  }

  @override
  Widget build(BuildContext context) {
    return _currentLocation == null
        ? CircularProgressIndicator()
        : AppRetainWidget(
            child: SpeedText(_convertedSpeed(), _speedStatus, speedUnit,
                this.stopwatch.elapsed),
          );
  }

  void _initTimer() {
    var callback = () {
      if (_currentLocation != null) {
        double convertedCurrentSpeed = _convertedSpeed();
        double _distanceToPrevious = 0;

        if (_previousLatitude != null && _previousLongitude != null) {
          _distanceToPrevious = _measure(_previousLatitude, _previousLongitude,
              _currentLocation.latitude, _currentLocation.longitude);
        }

        _previousLatitude = _currentLocation.latitude;
        _previousLongitude = _currentLocation.longitude;

        BlocProvider.of<RunningProgressBloc>(context).add(
            UpdateRunningProgressEvent(RunningProgressDatapoint(
                convertedCurrentSpeed, _distanceToPrevious)));

        debugPrint("Monitoring running speed... $convertedCurrentSpeed");
        if (convertedCurrentSpeed > Constants.MINIMUM_SPEED_TO_TRACK) {
          _speedStatus = SpeedStatus.ON_TIME;

          if (convertedCurrentSpeed < targetSpeed * Constants.LOWER_THRESHOLD) {
            _speedStatus = SpeedStatus.SLOW;
            debugPrint(
                "You're running too slow! Current: $convertedCurrentSpeed target: $targetSpeed");
          }

          if (convertedCurrentSpeed > targetSpeed * Constants.UPPER_THRESHOLD) {
            _speedStatus = SpeedStatus.FAST;
            debugPrint(
                "You're running too fast!: $convertedCurrentSpeed target: $targetSpeed");
          }
        }
      }
    };
    _timerFacade = _timerService.provideTimer(callback);
    _timerFacade.startTimer();
  }

  _measure(lat1, lon1, lat2, lon2) {
    var R = 6378.137;
    var dLat = lat2 * pi / 180 - lat1 * pi / 180;
    var dLon = lon2 * pi / 180 - lon1 * pi / 180;
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180) *
            cos(lat2 * pi / 180) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c;
    return d;
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

  double _convertedSpeed() {
    return _currentLocation.speed * _conversionRate ?? 0;
  }

  @override
  void dispose() {
    _timerFacade.stopTimer();
    _locationFacade.cancelLocationSubscription();
    _appRetainServiceInterface.stopService();
    stopwatch.stop();
    stopwatch.reset();
    super.dispose();
  }
}
