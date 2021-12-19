import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:runanonymous/bloc/running_target/running_target_bloc.dart';
import 'package:runanonymous/common/route_mapping.dart';
import 'package:runanonymous/generated/l10n.dart';
import 'package:runanonymous/screen/main_app.dart';
import 'package:runanonymous/screen/tracking_page.dart';
import 'package:runanonymous/service/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(RunanonymousApp());
}

class RunanonymousApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RunningTargetBloc>(
            create: (BuildContext context) => RunningTargetBloc())
      ],
      child: MaterialApp(
        theme: new ThemeData(
            primaryColor: Colors.white,
            primarySwatch: Colors.blue,
            accentColor: Colors.white,
            brightness: Brightness.dark,
            primaryTextTheme:
                TextTheme(headline6: TextStyle(color: Colors.white))),
        initialRoute: INITIAL_ROUTE.path,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        routes: {
          RouteMapping.HOME.path: (context) => _AppTemplate(MainPage()),
          RouteMapping.TRACKING.path: (context) => _AppTemplate(TrackingPage())
        },
      ),
    );
  }
}

/// Generic layout for views.
class _AppTemplate extends StatelessWidget {
  _AppTemplate(this.widget);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).topbarTitle),
          backgroundColor: Colors.green[900],
        ),
        body: Container(
            decoration: BoxDecoration(
              color: Colors.black87,
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstATop),
                image: AssetImage("assets/images/forest_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: widget));
  }
}
