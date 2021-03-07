import 'package:runanonymous/service/timer/timer_facade.dart';
import 'package:runanonymous/service/timer/timer_interface.dart';
import 'package:runanonymous/service/timer/timer_service_interface.dart';

class TimerService implements TimerServiceInterface {
  @override
  TimerInterface provideTimer(Function callback) {
    return TimerFacade(callback);
  }
}
