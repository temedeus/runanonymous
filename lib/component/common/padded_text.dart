import 'package:flutter/cupertino.dart';

class PaddedText extends StatelessWidget {
  final String text;
  final double fontSize;
  PaddedText(this.text, this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
      ),
    );
  }
}
