import 'package:flutter_bloc/flutter_bloc.dart';
import 'dresion_event.dart';
import 'dresion_state.dart';

class DresionBloc extends Bloc<DresionEvent, DresionState> {
  DresionBloc() : super(DresionInitial()) {
    on<DresionInitialEvent>(_onDresionInitialEvent);
  }

  void _onDresionInitialEvent(
    DresionInitialEvent event,
    Emitter<DresionState> emit,
  ) {
    emit(DresionInitial());
  }
}
