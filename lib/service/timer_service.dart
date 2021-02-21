import 'package:runanonymous/model/timer_facade.dart';
import 'package:runanonymous/model/timer_interface.dart';
import 'package:runanonymous/service/timer_service_interface.dart';

class TimerService implements TimerServiceInterface {
  @override
  TimerInterface provideTimer(Function callback) {
    return TimerFacade(callback);
  }
}
