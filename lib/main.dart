import 'package:flutter/material.dart';
import 'package:runanonymous/bloc/BlocProvider.dart';
import 'package:runanonymous/bloc/RunningTargetBloc.dart';
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
            accentColor: Colors.white,
            brightness: Brightness.dark,
            primaryTextTheme:
                TextTheme(headline6: TextStyle(color: Colors.white))),
        initialRoute: INITIAL_ROUTE.path,
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
  final RunningTargetBloc runningTargetBloc = new RunningTargetBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: RunningTargetBloc(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Runonymous'),
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
              child: widget)),
    );
  }
}
