import 'package:runanonymous/model/timer_interface.dart';

abstract class TimerServiceInterface {
  TimerInterface provideTimer(Function callback);
}
