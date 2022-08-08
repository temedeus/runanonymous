import 'package:runanonymous/service/timer/timer_facade.dart';
import 'package:runanonymous/service/timer/timer_service.dart';

import 'TimerFacadeMock.dart';

class TimerServiceMock implements TimerServiceInterface {
  @override
  TimerFacade provideTimer(Function callback) {
    return TimerFacadeMock();
  }
}
