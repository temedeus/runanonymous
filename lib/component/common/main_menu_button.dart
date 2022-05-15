import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  MenuButton(this.title, this.callback);
  final String title;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: callback,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(title, style: TextStyle(fontSize: 20)),
    );
  }
}
