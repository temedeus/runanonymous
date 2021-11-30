# Runonymous

Simple running pacer that persists no user data. All running data and tracking are kept within 
client application only (aside from what Google/Apple might gather by default just by using the device, but that 
is another story and out of the developer's hands). Native geolocation is used to track user speed, but location is not 
stored or used for other purposes. User is given both visual and audio cues on current speed.

## Running application
To run from command line
```
flutter pub get
flutter pub outdated
flutter pub upgrade
flutter run lib/main.dart
```

To run from IDE, install possible Flutter/Dart plugins for convenience and run main.dart. For more specific instructions please view your IDE website. (Using, for example, Android Studio everything should be quite straightforward.)

## Initiate localizations
To generate localisations run:
```
pub global run intl_utils:generate
```
I highly recommend installing following plugin for IntelliJ/Android Studio:

https://plugins.jetbrains.com/plugin/13666-flutter-intl
