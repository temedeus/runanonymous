import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:runanonymous/bloc/running_time.dart';
import 'package:runanonymous/generated/l10n.dart';
import 'package:runanonymous/validator/validators.dart';

import '../common/number_input_field.dart';

class TimeInput extends StatefulWidget {
  TimeInput({Key key, this.changeListener}) : super(key: key);

  final Function changeListener;

  @override
  _TimeInputState createState() =>
      _TimeInputState(changeListener: changeListener);
}

class _TimeInputState extends State<TimeInput> {
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _minuteController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final Function changeListener;

  _TimeInputState({this.changeListener}) {
    addControllerListeners(changeListener);
  }

  void addControllerListeners(Function changeAction) {
    VoidCallback timeInputChangeListener = () {
      changeAction.call(
          _hourController.text, _minuteController.text, _secondController.text);
    };
    _hourController.addListener(timeInputChangeListener);
    _minuteController.addListener(timeInputChangeListener);
    _secondController.addListener(timeInputChangeListener);
    _hourController.text = "0";
    _minuteController.text = "0";
    _secondController.text = "0";
  }

  void _showDialog(controller, hourLocale) {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 0,
            maxValue: 60,
            title: new Text(hourLocale),
            initialIntegerValue: int.tryParse(controller.text),
          );
        }).then((value) => {
          if (value != null) {controller.text = value.toString()}
        });
  }

  List<Widget> getInputFields(BuildContext context) {
    return <Widget>[
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () => _showDialog(_hourController, S.of(context).commonHours),
          child: NumberInputField(
            S.of(context).commonHours,
            controller: _hourController,
            validator: Validators().getNumberRangeValidator(0, 200),
            enabled: false,
          ),
        ),
      ),
      Expanded(
          flex: 1,
          child: InkWell(
            onTap: () =>
                _showDialog(_minuteController, S.of(context).commonMinutes),
            child: NumberInputField(
              S.of(context).commonMinutes,
              controller: _minuteController,
              validator: Validators().getNumberRangeValidator(0, 60),
              enabled: false,
            ),
          )),
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () =>
              _showDialog(_secondController, S.of(context).commonSeconds),
          child: NumberInputField(
            S.of(context).commonSeconds,
            controller: _secondController,
            validator: Validators().getNumberRangeValidator(0, 60),
            enabled: false,
          ),
        ),
      )
    ];
  }

  void updateComponent(RunningTime runningTime) {
    _hourController.text = runningTime.hour.toString();
    _minuteController.text = runningTime.minute.toString();
    _secondController.text = runningTime.seconds.toString();
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: getInputFields(context),
        ),
      ],
    );
  }
}
