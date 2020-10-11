import 'package:flutter/cupertino.dart';
import 'package:runanonymous/bloc/running_time.dart';
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
      changeAction.call("${_hourController.text}", "${_minuteController.text}",
          "${_secondController.text}");
    };
    _hourController.addListener(timeInputChangeListener);
    _minuteController.addListener(timeInputChangeListener);
    _secondController.addListener(timeInputChangeListener);
  }

  List<Widget> getInputFields() {
    return <Widget>[
      Expanded(
        flex: 1,
        child: NumberInputField(
          "Hours",
          controller: _hourController,
          validator: Validators().getNumberRangeValidator(0, 200),
        ),
      ),
      Expanded(
        flex: 1,
        child: NumberInputField(
          "Minutes",
          controller: _minuteController,
          validator: Validators().getNumberRangeValidator(0, 60),
        ),
      ),
      Expanded(
        flex: 1,
        child: NumberInputField(
          "Seconds",
          controller: _secondController,
          validator: Validators().getNumberRangeValidator(0, 60),
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
          children: getInputFields(),
        ),
      ],
    );
  }
}
