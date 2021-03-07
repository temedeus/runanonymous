import 'package:runanonymous/service/timer/timer_interface.dart';

abstract class TimerServiceInterface {
  TimerInterface provideTimer(Function callback);
}
