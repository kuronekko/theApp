import 'package:flutter/material.dart';
import 'package:the_app/login/LoginPage.dart';
import 'package:the_app/pages/HomePage.dart';


  route(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return new MyCustomRoute(
          builder: (_) => new LoginPage(),
          settings: settings,
        );
      case '/home':
        return new MyCustomRoute(
          builder: (_) => new HomePage(),
          settings: settings,
        );
    }
  }


class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}
