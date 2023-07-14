import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:counter_app/logic/cubit/counter_cubit.dart';
import 'package:counter_app/logic/cubit/internet_cubit.dart';
import 'package:counter_app/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(
      appRouter: AppRouter(),
      connectivity: Connectivity(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({super.key, required this.appRouter, required this.connectivity});

  @override
  Widget build(BuildContext context) {
    // global access because i wrapped the MaterialApp with BlocProvider
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => InternetCubit(connectivity: connectivity)),
          BlocProvider(create: (context) => CounterCubit())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity:
                VisualDensity.adaptivePlatformDensity, // for responsive UI
          ),
          onGenerateRoute: appRouter.onGenerateRoute,
        ));
  }
}

//#6 - BLoC Access & Navigation - Local, Route & Global Access with BlocProvider
// https://www.youtube.com/watch?v=laqnY0NjU3M&list=PLptHs0ZDJKt_T-oNj_6Q98v-tBnVf-S_o&index=7
