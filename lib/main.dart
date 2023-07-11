import 'package:counter_app/logic/cubit/counter_cubit.dart';
import 'package:counter_app/presentation/router/app_router.dart';
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
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    // global access because i wrapped the MaterialApp with BlocProvider
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity:
              VisualDensity.adaptivePlatformDensity, // for responsive UI
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }


}

//#6 - BLoC Access & Navigation - Local, Route & Global Access with BlocProvider
// https://www.youtube.com/watch?v=laqnY0NjU3M&list=PLptHs0ZDJKt_T-oNj_6Q98v-tBnVf-S_o&index=7
