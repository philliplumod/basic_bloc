import 'package:counter_app/constants/enums.dart';
import 'package:counter_app/logic/cubit/counter_cubit.dart';
import 'package:counter_app/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title, this.color})
      : super(key: key);

  final String title;
  final Color? color;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.wifi) {
          context.read<CounterCubit>().increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.mobile) {
          context.read<CounterCubit>().decrement();
        } else if (state is InternetDisconnected) {
          context.read<CounterCubit>().increment();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.title),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                BlocBuilder<InternetCubit, InternetState>(
                    builder: (context, state) {
                  return const CircularProgressIndicator();
                }),
                const Text('You have pushed the button this many times:'),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        // blocprovider is creates and provides THE ONLY INSTANCE of a bloc to the subtree
                        BlocProvider.of<CounterCubit>(context).decrement();
                      },
                      heroTag: 'btn1',
                      child: const Icon(Icons.remove),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        BlocProvider.of<CounterCubit>(context).increment();
                        // context.read<CounterCubit>().increment();
                      },
                      heroTag: 'btn2',
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/second',
                        );
                      },
                      child: const Text(
                        'Go to Second Screen',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/third');
                      },
                      child: const Text(
                        'Go to Third Screen',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
