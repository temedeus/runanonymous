import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runanonymous/common/route_mapping.dart';
import 'package:runanonymous/common/unit/distance_unit.dart';
import 'package:runanonymous/common/unit/speed_unit.dart';
import 'package:runanonymous/component/common/main_menu_button.dart';
import 'package:runanonymous/generated/l10n.dart';
import 'package:runanonymous/screen/results_page_arguments.dart';
import 'package:runanonymous/screen/speed_average_list.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final resultsPageArguments =
        ModalRoute.of(context).settings.arguments as ResultsPageArguments;
    var items = resultsPageArguments.averageSpeeds;
    SpeedUnit speedunit = resultsPageArguments.speedUnitClear;
    DistanceUnit distanceUnit = resultsPageArguments.distanceUnit;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(S.of(context).averageSpeed, style: const TextStyle(fontSize: 48)),
        SpeedAverageList(items, speedunit, distanceUnit),
        MenuButton(
            S.of(context).backToMain,
            () => Navigator.of(context)
                .popUntil(ModalRoute.withName(RouteMapping.HOME.path))),
      ],
    );
  }
}
