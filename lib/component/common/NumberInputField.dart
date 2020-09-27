import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runanonymous/validator/Validators.dart';

class NumberInputField extends StatelessWidget {
  NumberInputField(this.label,
      {this.onSaved,
      this.validator,
      this.hintText,
      this.controller,
      this.enabled = true});

  final String label;

  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String hintText;
  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(labelText: label, hintText: hintText),
        keyboardType: TextInputType.number,
        inputFormatters: [],
        enabled: enabled,
        controller: controller,
        validator: validator != null
            ? validator
            : Validators().defaultNumericValidator,
        onSaved: onSaved);
  }
}
