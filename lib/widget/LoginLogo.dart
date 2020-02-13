import 'package:flutter/material.dart';

class LoginLogoConf extends StatelessWidget {
  final DecorationImage image;
  LoginLogoConf({this.image});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      width: 300.0,
      height: 250.0,
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        image: image,
      ),
    ));
  }
}
