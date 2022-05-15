class Util {
  parseStopWatchTime(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes - 60 * hours;
    final seconds = duration.inSeconds - 60 * duration.inMinutes;

    return hours.toString().padLeft(2, '0') +
        ":" +
        minutes.toString().padLeft(2, '0') +
        ":" +
        seconds.toString().padLeft(2, '0');
  }
}
