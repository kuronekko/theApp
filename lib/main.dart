
import 'package:flutter/material.dart';
import 'package:the_app/login/LoginPage.dart';
import 'package:the_app/pages/SplashScreenPage.dart';
import 'package:the_app/utils/Routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreenPage(),
      onGenerateRoute: (RouteSettings settings) => route(settings),
    );
  }
}
