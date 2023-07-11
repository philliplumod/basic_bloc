import 'package:counter_app/logic/cubit/counter_cubit.dart';
import 'package:counter_app/presentation/screens/home_screen.dart';
import 'package:counter_app/presentation/screens/second_screen.dart';
import 'package:counter_app/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final CounterCubit _counterCubit = CounterCubit();
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _counterCubit,
            child: const HomeScreen(
              title: 'Flutter Demo Home Page',
              color: Colors.blueAccent,
            ),
          ),
        );

      case '/second':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _counterCubit,
            child: const SecondScreen(
              title: 'Second Screen',
              color: Colors.redAccent,
            ),
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _counterCubit,
            child: const ThirdScreen(
              title: 'Third Screen',
              color: Colors.greenAccent,
            ),
          ),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _counterCubit,
                  child: const HomeScreen(
                    title: 'Flutter Demo Home Page',
                    color: Colors.blueAccent,
                  ),
                ));
    }
  }

  void dispose() {
    _counterCubit.close();
  }
}
