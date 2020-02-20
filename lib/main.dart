
import 'package:flutter/material.dart';
import 'package:the_app/pages/SplashScreenPage.dart';
import 'package:the_app/utils/Routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color.fromRGBO(32, 33, 36, 1.0),
          appBarTheme: AppBarTheme(),
          primarySwatch: Colors.blue,
          primaryColor: Color.fromRGBO(48, 49, 52, 1.0),
          accentColor: Color(int.parse('0xff2399CC')),
          iconTheme: IconThemeData(color: Colors.white)),
      home: SplashScreenPage(),
      onGenerateRoute: (RouteSettings settings) => route(settings),
    );
  }
}
