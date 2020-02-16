
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  VideoPlayerController _playerController;

  @override
  void initState(){

    _playerController = VideoPlayerController.asset('assets/videos/HeartBeatSplash.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _playerController.play();
        });
      });

    //Instancia Firebase
    Future futureA = Future.delayed(Duration(seconds: 4));
    Future<FirebaseUser> futureB = FirebaseAuth.instance.currentUser();


    Future.wait([futureA,futureB]).then((List values){
      FirebaseUser authentication = values[1];
      if(authentication != null){
        Navigator.pushNamed(context, "/home");
      }else{
        Navigator.pushNamed(context, "/login");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _playerController.dispose();
  }

  Widget build(BuildContext context) {
    return  new AspectRatio(
        aspectRatio: 9 / 16,
        child: Container(
          child: (_playerController != null
              ? VideoPlayer(
            _playerController,
          )
              : Container()),
        ));
  }
}
