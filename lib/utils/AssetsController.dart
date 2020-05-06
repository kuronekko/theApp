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
ImageProvider animeIcon = AssetImage("assets/images/animeIcon.png");
ImageProvider arieIcon = AssetImage("assets/images/arieIcon.png");
ImageProvider mangaPage = AssetImage("assets/images/mangaPage.jpg");


VideoPlayerController splashVideo = VideoPlayerController.asset('assets/videos/HeartBeatSplash.mp4');