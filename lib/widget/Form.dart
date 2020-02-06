import 'package:flutter/material.dart';
import './InputFields.dart';

class FormContainer extends StatelessWidget {

  final _focusSenha = FocusNode();

  @override
  Widget build(BuildContext context) {
    return (new Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
              child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new InputFieldArea(
                hint: "Username",
                obscure: false,
                icon: Icons.person_outline,
                nextFocus: _focusSenha,
              ),
              new InputFieldArea(
                hint: "Password",
                obscure: true,
                icon: Icons.lock_outline,
                focusNode: _focusSenha,
              ),
            ],
          )),
        ],
      ),
    ));
  }
}
