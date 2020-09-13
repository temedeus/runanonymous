import 'package:flutter/material.dart';
import 'package:runanonymous/common/RouteMapping.dart';
import 'package:runanonymous/screen/MainApp.dart';
import 'package:runanonymous/screen/TrackingPage.dart';

void main() => runApp(RunanonymousApp());

class RunanonymousApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: new ThemeData(
          primaryColor: Colors.white,
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        initialRoute: "/",
        routes: {
          RouteMapping.HOME.path: (context) =>
              _RunanonymousTemplate(MainPage()),
          RouteMapping.TRACKING.path: (context) =>
              _RunanonymousTemplate(TrackingPage())
        });
  }
}

/// Generic layout for views.
class _RunanonymousTemplate extends StatelessWidget {
  _RunanonymousTemplate(this.widget);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ranonymous'),
          backgroundColor: Colors.green[900],
        ),
        body: Container(
            decoration: BoxDecoration(
              color: Colors.black87,
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstATop),
                image: AssetImage("images/forest_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: widget));
  }
}
