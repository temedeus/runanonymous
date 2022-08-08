import 'dart:async';

class TimerFacade {
  Timer _timer;
  Function _callback;

  TimerFacade(this._callback);

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _callback();
    });
  }

  void stopTimer() {
    _timer.cancel();
  }
}
