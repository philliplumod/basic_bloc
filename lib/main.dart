import 'package:counter_app/logic/cubit/counter_cubit.dart';
import 'package:counter_app/presentation/screens/home_screen.dart';
import 'package:counter_app/presentation/screens/second_screen.dart';
import 'package:counter_app/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterCubit _counterCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        routes: {
          '/': (context) => BlocProvider.value(
            value: _counterCubit,
            child: const HomeScreen(
                  title: 'Flutter Demo Home Page',
                  color: Colors.blueAccent,
                ),
          ),
          '/second': (context) => BlocProvider.value(
            value: _counterCubit,
            child: const SecondScreen(
                  title: 'Second Screen',
                  color: Colors.redAccent,
                ),
          ),
          '/third': (context) => BlocProvider.value(
            value: _counterCubit,
            child: const ThirdScreen(
                  title: 'Third Screen',
                  color: Colors.greenAccent,
                ),
          ),
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _counterCubit.close();
    super.dispose();
  }
}






//#6 - BLoC Access & Navigation - Local, Route & Global Access with BlocProvider
// https://www.youtube.com/watch?v=laqnY0NjU3M&list=PLptHs0ZDJKt_T-oNj_6Q98v-tBnVf-S_o&index=7