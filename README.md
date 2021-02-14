# Runonymous

Simple running pacer that persists nothing of user. All running data and tracking are kept within 
client only (aside from what Google/Apple might gather by default just by using the device, but that 
is another story and out of the (*Runanonymous* developer's hands). App itself makes no effort to
store any data whatsoever. Native geolocation is used to track user speed, but location is not 
stored or used for other purposes.

## Initiate localizations
To generate localisations run:
```
pub global run intl_utils:generate
```
I highly recommend installing following plugin for IntelliJ/Android Studio:
https://plugins.jetbrains.com/plugin/13666-flutter-intl