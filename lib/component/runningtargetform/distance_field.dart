import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runanonymous/bloc/running_target_bloc.dart';
import 'package:runanonymous/bloc/running_time_event.dart';
import 'package:runanonymous/common/unit/distance_unit.dart';
import 'package:runanonymous/component/common/form_dropdown_widget.dart';
import 'package:runanonymous/component/common/form_item.dart';
import 'package:runanonymous/component/common/number_input_field.dart';
import 'package:runanonymous/generated/l10n.dart';

class DistanceField extends StatefulWidget {
  DistanceField({Key key}) : super(key: key);

  @override
  _DistanceFieldState createState() => _DistanceFieldState();
}

class _DistanceFieldState extends State<DistanceField> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      BlocProvider.of<RunningTargetBloc>(context)
          .add(UpdateDistanceEvent(double.tryParse(controller.text)));
    });
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: NumberInputField(
                    S.of(context).runningTargetFormDistanceFieldCaption,
                    onSaved: (String value) {},
                    hintText: "0",
                    controller: controller,
                  ),
                )),
            Expanded(
                child: FormDropDownWidget(
              labelText: S.of(context).runningTargetFormDistancefieldUnit,
              items: [
                FormItem()
                  ..value = DistanceUnit.KM.unit
                  ..displayValue = DistanceUnit.KM.unit,
                FormItem()
                  ..value = DistanceUnit.M.unit
                  ..displayValue = DistanceUnit.M.unit
              ],
              initialValue: DistanceUnit.KM.unit,
              valueChanged: (newValue) {
                DistanceUnit distanceUnit =
                    DistanceUnitHelper.valueOf(newValue);
                BlocProvider.of<RunningTargetBloc>(context)
                    .add(UpdateDistanceUnitEvent(distanceUnit));
                BlocProvider.of<RunningTargetBloc>(context)
                    .add(UpdateSpeedUnitEvent(distanceUnit.matchingSpeedUnit));
              },
            ))
          ],
        ),
      ],
    );
  }
}
