import 'dart:developer';

import 'package:counter_app/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: const MaterialApp(
        home: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('You have pushed the button this many times:'),
                // bloc Consumer is the same as bloc builder but it does not rebuild the UI for every new state coming from the bloc
                BlocConsumer<CounterCubit, CounterState>(
                  listener: (context, state) {
                    if (state.wasIncremented == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Incremented!'),
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    } else if (state.wasIncremented == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Decremented!'),
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Text(state.counterValue.toString());
                  },
                ),

                // BlocBuilder<CounterCubit, CounterState>(
                //   //blocbuilder re-builds the UI FOR EVERY NEW STATE coming from the bloc
                //   builder: (context, state) {
                //     return Text(state.counterValue.toString());
                //   },
                // ),

                // BlocListener<CounterCubit, CounterState>(
                //   listener: (context, state) {
                //     // TODO: implement listener
                //   },
                //   child: Text(
                //     context.watch<CounterCubit>().state.counterValue.toString(),
                //     style: Theme.of(context).textTheme.headlineMedium,
                //   ),
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        // blocprovider is creates and provides THE ONLY INSTANCE of a bloc to the subtree
                        BlocProvider.of<CounterCubit>(context).decrement();
                      },
                      child: const Icon(Icons.remove),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        BlocProvider.of<CounterCubit>(context).increment();
                        // context.read<CounterCubit>().increment();
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                )
              ])),
    );
  }
}
