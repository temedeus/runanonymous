import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainMenuButton extends StatelessWidget {
  MainMenuButton(this.title, this.callback);
  final String title;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: callback,
      child: Text(title, style: TextStyle(fontSize: 20)),
    );
  }
}
