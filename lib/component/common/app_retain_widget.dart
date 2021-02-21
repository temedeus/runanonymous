import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:runanonymous/common/backend_method.dart';

class AppRetainWidget extends StatelessWidget {
  const AppRetainWidget({Key key, this.child}) : super(key: key);

  final Widget child;

  final _channel = const MethodChannel('com.example.simplerunner/app_retain');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          _channel.invokeMethod(ServiceMethod.SEND_TO_FOREGROUND.method);
        }
        return false;
      },
      child: child,
    );
  }
}