
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState(){

    //Instancia Firebase
    Future futureA = Future.delayed(Duration(seconds: 3));
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

  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(), //TO DO
      ),
    );
  }
}
