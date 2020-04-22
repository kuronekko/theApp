import 'package:flutter/material.dart';

class AppState{
  final int animationStatusLogin;

  AppState({@required this.animationStatusLogin});

  factory AppState.initialState(){
    return AppState(
        animationStatusLogin: 0
    );
  }

  AppState copyWith({int animationStatusLogin}){
    return AppState(
        animationStatusLogin: animationStatusLogin ?? this.animationStatusLogin
    );
  }

  int get statusAnimationStatusLogin => animationStatusLogin;
}