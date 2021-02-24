import 'package:location/location.dart';

abstract class LocationInterface {
  void ensureLocationAvailable(void onData(LocationData event));
  void cancelLocationSubscription();
}
