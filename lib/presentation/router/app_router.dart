
import 'package:counter_app/presentation/screens/home_screen.dart';
import 'package:counter_app/presentation/screens/second_screen.dart';
import 'package:counter_app/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(
            title: 'Flutter Demo Home Page',
            color: Colors.blueAccent,
          ),
        );

      case '/second':
        return MaterialPageRoute(
          builder: (_) => const SecondScreen(
            title: 'Second Screen',
            color: Colors.redAccent,
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => const ThirdScreen(
            title: 'Third Screen',
            color: Colors.greenAccent,
          ),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(
              title: 'Flutter Demo Home Page',
              color: Colors.blueAccent,
            ));
    }
  }


}
