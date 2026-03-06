import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testt/features/counter/bloc/counter_event.dart';
import 'package:flutter_testt/features/counter/bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    on<IncrementEvent>(_onIncrement);
    on<DecrementEvent>(_onDecrement);
    on<ResetEvent>(_onReset);
  }

  void _onIncrement(IncrementEvent event, Emitter<CounterState> emit) {
    emit(state.copyWith(counter: state.counter + 1));
  }

  void _onDecrement(DecrementEvent event, Emitter<CounterState> emit) {
    emit(state.copyWith(counter: state.counter - 1));
  }

  void _onReset(ResetEvent event, Emitter<CounterState> emit) {
    emit(CounterState.initial());
  }
}
