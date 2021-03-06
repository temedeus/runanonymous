import 'dart:io';

import 'package:flutter/material.dart';
import 'package:runanonymous/common/app_retain_service_method.dart';

class AppRetainWidget extends StatelessWidget {
  const AppRetainWidget({Key key, this.child}) : super(key: key);

  final Widget child;

  final _channel = AppRetainServiceMethod.METHOD_CHANNEL;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          _channel.invokeMethod(AppRetainServiceMethod.SEND_TO_FOREGROUND);
        }
        return false;
      },
      child: child,
    );
  }
}
