import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runanonymous/validator/Validators.dart';

class NumberInputField extends StatelessWidget {
  NumberInputField(this.label, this.onSaved, {this.validator, this.hintText});

  final String label;

  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(labelText: label, hintText: hintText),
        keyboardType: TextInputType.number,
        inputFormatters: [],
        validator: validator != null
            ? validator
            : Validators().defaultNumericValidator,
        onSaved: onSaved);
  }
}
