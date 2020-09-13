import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:runanonymous/component/RunningTargetForm.dart';

/// Main page where user inputs running data.
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[RunningTargetForm()],
    );
  }
}
