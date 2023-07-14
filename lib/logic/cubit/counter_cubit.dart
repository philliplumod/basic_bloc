import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:counter_app/constants/enums.dart';
import 'package:counter_app/logic/cubit/internet_cubit.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  StreamSubscription? internetStreamSubscription;

  CounterCubit({required this.internetCubit})
      : super(CounterState(counterValue: 0)) {
    monitorInternetCubit();
  }

  StreamSubscription<InternetState> monitorInternetCubit() {
    return internetStreamSubscription =
        internetCubit.stream.listen((interState) {
      if (interState is InternetConnected &&
          interState.connectionType == ConnectionType.wifi) {
        increment();
      } else if (interState is InternetConnected &&
          interState.connectionType == ConnectionType.mobile) {
        decrement();
      }
    });
  }

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));
  @override
  Future<void> close() {
    internetStreamSubscription?.cancel();
    return super.close();
  }
}
