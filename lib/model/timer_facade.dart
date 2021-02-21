import 'dart:async';

import 'package:runanonymous/model/timer_interface.dart';

class TimerFacade implements TimerInterface {
  Timer _timer;
  Function _callback;

  TimerFacade(this._callback);

  @override
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _callback.call();
    });
  }

  @override
  void stopTimer() {
    _timer.cancel();
  }
}