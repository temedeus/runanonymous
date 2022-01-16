class SpeedAverageEntry {
  double distancePoint;
  double speedAverage;

  SpeedAverageEntry(this.distancePoint, this.speedAverage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpeedAverageEntry &&
          runtimeType == other.runtimeType &&
          distancePoint == other.distancePoint &&
          speedAverage == other.speedAverage;

  @override
  int get hashCode => distancePoint.hashCode ^ speedAverage.hashCode;
}
