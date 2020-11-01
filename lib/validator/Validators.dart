import 'package:flutter/cupertino.dart';

class Validators {
  final FormFieldValidator<String> defaultNumericValidator = (value) {
    if (value.isEmpty) {
      return "Empty values not allowed!";
    }

    if (double.tryParse(value.replaceAll(",", ".")) == null) {
      return 'Numeric values only!';
    }
    return null;
  };

  FormFieldValidator<String> getNumberRangeValidator(min, max) {
    return (value) {
      if (value.isEmpty) {
        return "Empty values not allowed!";
      }
      var hour = double.tryParse(value.replaceAll(",", "."));

      if (hour == null || hour < min || hour > max) {
        return "Range $min to  $max";
      }
      return null;
    };
  }
}
