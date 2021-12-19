import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:runanonymous/common/constants.dart';
import 'package:runanonymous/common/unit/speed_status.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';
import 'package:runanonymous/component/common/app_retain_widget.dart';
import 'package:runanonymous/component/speedometer/speed_text.dart';
import 'package:runanonymous/service/app_retain/app_retain_service_interface.dart';
import 'package:runanonymous/service/location/location_interface.dart';
import 'package:runanonymous/service/location/location_service_interface.dart';
import 'package:runanonymous/service/service_locator.dart';
import 'package:runanonymous/service/timer/timer_interface.dart';
import 'package:runanonymous/service/timer/timer_service_interface.dart';

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
  final LocationServiceInterface _locationService =
      locator<LocationServiceInterface>();
  final TimerServiceInterface _timerService = locator<TimerServiceInterface>();

  LocationInterface _locationFacade;
  LocationData _currentLocation;
  SpeedStatus _speedStatus = SpeedStatus.SLOW;
  TimerInterface _timerFacade;
  List<double> _speedList;

  _SpeedometerState(this.targetSpeed, this.speedUnit) {
    _locationFacade = _locationService.createLocation();
  }

  @override
  void initState() {
    super.initState();
    _initTimer();
    _locationFacade.ensureLocationAvailable((event) {
      setState(() {
        _currentLocation = event;
      });
    });
    _speedList = [];
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
        _speedList.add(convertedCurrentSpeed);

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
    //   Screen.keepOn(false);
    _locationFacade.cancelLocationSubscription();
    _appRetainServiceInterface.stopService();
    super.dispose();
  }
}
