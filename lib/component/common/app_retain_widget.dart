import 'dart:io';

import 'package:flutter/material.dart';
import 'package:runanonymous/service/app_retain/app_retain_service.dart';
import 'package:runanonymous/service/service_locator.dart';

class AppRetainWidget extends StatelessWidget {
  AppRetainWidget({Key key, this.child}) : super(key: key);

  final AppRetainService _appRetainServiceInterface =
      locator<AppRetainService>();
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          _appRetainServiceInterface.sendToForeground();
        }
        return false;
      },
      child: child,
    );
  }
}
