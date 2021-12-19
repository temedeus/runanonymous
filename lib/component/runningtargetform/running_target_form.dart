import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runanonymous/bloc/running_target/running_target_bloc.dart';
import 'package:runanonymous/bloc/running_target/running_time.dart';
import 'package:runanonymous/bloc/running_target/running_time_event.dart';
import 'package:runanonymous/common/route_mapping.dart';
import 'package:runanonymous/component/common/main_menu_button.dart';
import 'package:runanonymous/component/runningtargetform/distance_field.dart';
import 'package:runanonymous/generated/l10n.dart';

import 'time_input.dart';

/// Form for setting up targets for your running sessions. I.e. distance, time
/// and speed.
/// All data is temporarily used for nothing but calculating required speed.
class RunningTargetForm extends StatefulWidget {
  @override
  RunningTargetFormState createState() {
    return RunningTargetFormState();
  }
}

class RunningTargetFormState extends State<RunningTargetForm> {
  final _formKey = GlobalKey<FormState>();
  DistanceField _distanceField;
  TimeInput _timeInput;

  @override
  void initState() {
    _initiateFields();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: BlocProvider.of<RunningTargetBloc>(context),
      builder: (BuildContext context, state) {
        String targetSpeed =
            state.speed != null ? state.speed.toStringAsFixed(1) : "--";
        String targetSpeedText =
            S.of(context).runningTargetFormTargetSpeedText +
                targetSpeed.toString();
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _distanceField,
              _timeInput,
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    targetSpeedText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: MenuButton(
                      S.of(context).runningTargetFormStartButtonLabel, () {
                    _formSubmitAction();
                  })),
            ],
          ),
        );
      },
    );
  }

  void _formSubmitAction() {
    if (_formKey.currentState.validate()) {
      Navigator.pushNamed(context, RouteMapping.TRACKING.path);
    }
  }

  _createDistanceField() {
    return DistanceField();
  }

  _createTimeInput(context) {
    return TimeInput(
        changeListener: (hours, minutes, seconds) => {
              BlocProvider.of<RunningTargetBloc>(context).add(
                  UpdateRunningTimeEvent(RunningTime(int.tryParse(hours),
                      int.tryParse(minutes), int.tryParse(seconds))))
            });
  }

  _initiateFields() {
    _distanceField = _createDistanceField();
    _timeInput = _createTimeInput(context);
  }
}
