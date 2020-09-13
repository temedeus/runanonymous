import 'package:flutter/material.dart';

/// Stateful (dropdown value) form dropdown widget.
class FormDropDownWidget extends StatefulWidget {
  FormDropDownWidget(
      {Key key,
      @required this.labelText,
      @required this.items,
      this.initialValue})
      : super(key: key);

  final String labelText;
  final List<String> items;
  final String initialValue;

  @override
  _FormDropDownWidgetState createState() =>
      _FormDropDownWidgetState(labelText, items, initialValue: initialValue);
}

class _FormDropDownWidgetState extends State<FormDropDownWidget> {
  _FormDropDownWidgetState(this.labelText, this.items, {this.initialValue});
  final String initialValue;
  final String labelText;
  final List<String> items;
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      decoration: InputDecoration(labelText: labelText),
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
