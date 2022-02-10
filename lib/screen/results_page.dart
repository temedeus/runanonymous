import 'package:flutter/cupertino.dart';
import 'package:runanonymous/common/route_mapping.dart';
import 'package:runanonymous/component/common/main_menu_button.dart';
import 'package:runanonymous/generated/l10n.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context).settings.arguments as TrackingPageArguments;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        MenuButton(
            S.of(context).backToMain,
            () => Navigator.of(context)
                .popUntil(ModalRoute.withName(RouteMapping.HOME.path))),
      ],
    );
  }
}
