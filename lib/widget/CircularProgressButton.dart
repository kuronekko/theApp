import 'package:flutter/material.dart';

class CircularProgressButton extends StatelessWidget {
  String text;
  Function onPressed;
  Color color;
  Color textColor;
  bool showProgress;

  CircularProgressButton(this.text,
      {@required this.onPressed,
      this.color = Colors.blue,
      this.textColor = Colors.white,
      this.showProgress = false});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
      child: showProgress
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              text,
              style: TextStyle(color: textColor, fontSize: 22),
            ),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      onPressed: onPressed,
    );
  }
}
