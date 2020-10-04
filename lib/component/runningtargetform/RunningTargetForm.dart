// Create a Form widget.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runanonymous/bloc/BlocProvider.dart';
import 'package:runanonymous/bloc/RunningTargetBloc.dart';
import 'package:runanonymous/common/DistanceUnit.dart';
import 'package:runanonymous/common/RouteMapping.dart';
import 'package:runanonymous/common/SpeedUnit.dart';
import 'package:runanonymous/component/common/NumberInputField.dart';

import '../common/FormDropdownWidget.dart';
import '../common/MainMenuButton.dart';
import 'TimeInput.dart';

/// Form for setting up targets for your running sessions. I.e. distance, time
/// and speed.
/// App itself tracks speed only, but using distance and time you can have the
/// target speed calculated for you.
class RunningTargetForm extends StatefulWidget {
  @override
  RunningTargetFormState createState() {
    return RunningTargetFormState();
  }
}

class RunningTargetFormState extends State<RunningTargetForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RunningTargetBloc>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildDistanceField(),
          TimeInput(),
          _buildSpeedField(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: MainMenuButton("Start", () {
                formSubmitAction();
              })),
        ],
      ),
    );
  }

  Widget _buildDistanceField() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: NumberInputField(
                    "Distance",
                    onSaved: (String value) {},
                    hintText: "0",
                  ),
                )),
            Expanded(
                child: FormDropDownWidget(
              labelText: "Unit",
              items: [DistanceUnit.KM.unit, DistanceUnit.M.unit],
              initialValue: DistanceUnit.KM.unit,
            ))
          ],
        ),
      ],
    );
  }

  Widget _buildSpeedField() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: NumberInputField("Target Speed",
                      onSaved: (String value) {}, hintText: "0"),
                )),
            Expanded(
                child: FormDropDownWidget(
              labelText: "Unit",
              items: [SpeedUnit.KMH.unit, SpeedUnit.MPH.unit],
              initialValue: SpeedUnit.KMH.unit,
            ))
          ],
        ),
      ],
    );
  }

  void formSubmitAction() {
    if (_formKey.currentState.validate()) {
      Navigator.pushNamed(context, RouteMapping.TRACKING.path);
    }
  }
}
