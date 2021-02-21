import 'package:runanonymous/model/timer_interface.dart';
import 'package:runanonymous/service/timer_service_interface.dart';

import 'TimerFacadeMock.dart';

class TimerServiceMock implements TimerServiceInterface {
  @override
  TimerInterface provideTimer(Function callback) {
    return TimerFacadeMock();
  }
}
