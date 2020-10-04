// Create a Form widget.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runanonymous/bloc/running_target_bloc.dart';
import 'package:runanonymous/common/distance_unit.dart';
import 'package:runanonymous/common/route_mapping.dart';
import 'package:runanonymous/common/speed_unit.dart';
import 'package:runanonymous/component/common/number_input_field.dart';

import '../common/form_dropdown_widget.dart';
import '../common/main_menu_button.dart';
import 'time_input.dart';

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
    return BlocBuilder(
      cubit: BlocProvider.of<RunningTargetBloc>(context),
      builder: (BuildContext context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildDistanceField(),
              TimeInput(),
              _buildSpeedField(),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: MainMenuButton("Start ${state.speed}", () {
                    formSubmitAction();
                  })),
            ],
          ),
        );
      },
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
