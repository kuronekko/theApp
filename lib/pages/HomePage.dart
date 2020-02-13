import 'package:flutter/material.dart';
import 'package:the_app/utils/FirebaseAuthentication.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
          color: Colors.blue,
          child: Image(image: AssetImage("assets/horo.gif"), height: 35.0)),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Are you sure?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => _signOutGoogle(),
                child: new Text('Yes'),
              ),
            ],
          ),
    ) ??
        false;
  }

  void _signOutGoogle() async{
    service.signOutGoogle();
    Navigator.pushReplacementNamed(context, "/login");
  }
}
