import 'package:runanonymous/service/timer/timer_facade.dart';

class TimerServiceInterface {
  TimerFacade provideTimer(Function callback) {
    return TimerFacade(callback);
  }
}
