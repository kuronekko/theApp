import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:the_app/pages/login/actions/Actions.dart';
import 'package:the_app/redux/AppState.dart';
import 'package:the_app/utils/FirebaseAuthentication.dart';
import 'package:the_app/utils/ServiceResponse.dart';
import 'package:the_app/widget/FormContainerLogin.dart';
import 'package:the_app/widget/LoginLogo.dart';
import '../../utils/AssetsController.dart';
import 'LoginAnimation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with TickerProviderStateMixin {

  AnimationController _loginButtonController;

  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  //To Change
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
            onPressed: () =>
                exit(0),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return (new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
          body: new Container(
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: <Color>[
                      const Color.fromRGBO(0, 0, 0, 1),
                      const Color.fromRGBO(230, 230, 230, 1),
                    ],
                    stops: [0.2, 1.0],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.5),
                  )),
              child: _listView())),
    ));
  }

  ListView _listView() {
    return new ListView(
      padding: const EdgeInsets.all(0.0),
      children: <Widget>[
        StoreConnector<AppState, int>(
            converter: (store) => store.state.animationStatusLogin,
            builder: (context, animationStatusLogin) {
              return new Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(height: 50,),
                      new LoginLogoConf(image: logoLogin),
                      //new FormContainerLogin(),
                      //new SignUp(), //To remove
                      new Padding(padding: const EdgeInsets.only(top: 140.0,),),
                    ],
                  ),
                  int.parse(animationStatusLogin.toString()) == 0
                      ? new Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: new InkWell(
                        child: _signInButtonGoogle()),
                  )
                      : new StaggerAnimation(
                      buttonController:
                      _loginButtonController.view),
                ],
              );
            }
        ),
      ],
    );
  }

  _signInButtonGoogle() {
    return Container(
      width: 320.0,
      height: 60.0,
      alignment: FractionalOffset.center,
      child: (new OutlineButton(
        splashColor: Colors.blueAccent,
        onPressed: () => _signInWithGoogle(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: googleLogo, height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Logue-se com o Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  void _signInWithGoogle() async {
    final service = FirebaseService();
    ServiceResponse response = await service.signInWithGoogle();
    if (response.ok) {
      StoreProvider.of<AppState>(context).dispatch(AnimationStatusLoginChange(1));
      _playAnimation();
    } else {
      //alert(context, response.msg);
    }
  }
}
