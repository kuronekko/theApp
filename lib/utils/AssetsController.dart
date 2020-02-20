import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

DecorationImage backgroundImage = new DecorationImage(
  image: new ExactAssetImage('assets/images/logoLogin.png'),
  fit: BoxFit.cover,
);

DecorationImage logoLogin = new DecorationImage(
  image: new ExactAssetImage('assets/images/logoLogin.png'),
  fit: BoxFit.cover,
);

ImageProvider googleLogo = AssetImage("assets/images/googleSignIn.png");

VideoPlayerController splashVideo = VideoPlayerController.asset('assets/videos/HeartBeatSplash.mp4');