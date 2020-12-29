// Create a Form widget.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runanonymous/bloc/running_target_bloc.dart';
import 'package:runanonymous/bloc/running_time.dart';
import 'package:runanonymous/bloc/running_time_event.dart';
import 'package:runanonymous/common/route_mapping.dart';
import 'package:runanonymous/component/runningtargetform/distance_field.dart';
import 'package:runanonymous/generated/l10n.dart';

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
        String targetSpeed =
            state.speed != null ? state.speed.toStringAsFixed(1) : "--";
        String targetSpeedText =
            S.of(context).runningTargetFormTargetSpeedText +
                targetSpeed.toString();
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DistanceField(),
              TimeInput(
                  changeListener: (hours, minutes, seconds) => {
                        BlocProvider.of<RunningTargetBloc>(context).add(
                            UpdateRunningTimeEvent(RunningTime(
                                int.tryParse(hours),
                                int.tryParse(minutes),
                                int.tryParse(seconds))))
                      }),
              //_buildSpeedUnitField(BlocProvider.of<RunningTargetBloc>(context)),
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
                    formSubmitAction();
                  })),
            ],
          ),
        );
      },
    );
  }

  void formSubmitAction() {
    if (_formKey.currentState.validate()) {
      Navigator.pushNamed(context, RouteMapping.TRACKING.path);
    }
  }
}
