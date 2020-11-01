class RunningTime {
  int hour;
  int minute;
  int seconds;

  bool get empty {
    return hour == null && minute == null && seconds == null;
  }
}
