// Create a Form widget.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runanonymous/bloc/RunningTargetBloc.dart';
import 'package:runanonymous/common/DistanceUnit.dart';
import 'package:runanonymous/common/RouteMapping.dart';
import 'package:runanonymous/common/SpeedUnit.dart';
import 'package:runanonymous/component/common/NumberInputField.dart';
import 'package:runanonymous/model/RunningTarget.dart';
import 'package:runanonymous/validator/Validators.dart';

import 'common/FormDropdownWidget.dart';
import 'common/MainMenuButton.dart';

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
  int _distance;

  int _time;
  int _speed;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildDistanceField(),
          _buildTimeField(),
          _buildSpeedField(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: MainMenuButton("Start", getStartTrackingCallback())),
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
                    (String value) {
                      setState(() {
                        _distance = int.tryParse(value);
                      });
                    },
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

  Widget _buildTimeField() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: NumberInputField("Hours", (text) {},
                  hintText: "00",
                  validator: Validators().getNumberRangeValidator(0, 100)),
            ),
            Expanded(
              flex: 1,
              child: NumberInputField("Minutes", (text) {},
                  hintText: "00",
                  validator: Validators().getNumberRangeValidator(0, 60)),
            ),
            Expanded(
              flex: 1,
              child: NumberInputField("Seconds", (text) {},
                  hintText: "00",
                  validator: Validators().getNumberRangeValidator(0, 60)),
            )
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
                  child: NumberInputField(
                    "Speed",
                    (String value) {
                      setState(() {
                        _speed = int.tryParse(value);
                      });
                    },
                    hintText: "0",
                  ),
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

  VoidCallback getStartTrackingCallback() {
    RunningTarget target = new RunningTarget();

    return () => {
          if (_formKey.currentState.validate())
            {
              runningTargetBloc.updateRunningTarget(target),
              Navigator.pushNamed(context, RouteMapping.TRACKING.path)
            }
        };
  }
}
