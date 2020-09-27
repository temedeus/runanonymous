import 'package:flutter/cupertino.dart';
import 'package:runanonymous/bloc/RunningTargetBloc.dart';
import 'package:runanonymous/model/RunningTime.dart';

import '../common/NumberInputField.dart';

class TimeInput extends StatefulWidget {
  TimeInput({Key key}) : super(key: key);

  @override
  _TimeInputState createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _minuteController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();

  _TimeInputState() {
    addControllerListeners();
  }

  void addControllerListeners() {
    VoidCallback listener = () => {
          runningTargetBloc.updateTime(RunningTime()
            ..hour = int.tryParse(_hourController.text)
            ..minute = int.tryParse(_minuteController.text)
            ..seconds = int.tryParse(_secondController.text))
        };
    _hourController.addListener(listener);
    _minuteController.addListener(listener);
    _secondController.addListener(listener);
  }

  List<Widget> getInputFields() {
    String _hintText = "";
    return <Widget>[
      createInputField(
        "Hours",
        _hintText,
        _hourController,
      ),
      createInputField(
        "Minutes",
        _hintText,
        _minuteController,
      ),
      createInputField(
        "Seconds",
        _hintText,
        _secondController,
      )
    ];
  }

  Expanded createInputField(title, hint, controller) {
    return Expanded(
      flex: 1,
      child: NumberInputField(
        "Seconds",
        hintText: hint,
        controller: controller,
      ),
    );
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
