import 'package:flutter_bloc/flutter_bloc.dart';
import 'keypad_event.dart';
import 'keypad_state.dart';

class KeypadBloc extends Bloc<KeypadEvent, KeypadState> {
  KeypadBloc() : super(const KeypadInitial()) {
    on<KeypadInitialEvent>(_onKeypadInitialEvent);
    on<KeypadNumberPressedEvent>(_onKeypadNumberPressedEvent);
    on<KeypadBackspacePressedEvent>(_onKeypadBackspacePressedEvent);
    on<KeypadClearEvent>(_onKeypadClearEvent);
    on<KeypadSubmitEvent>(_onKeypadSubmitEvent);
  }

  void _onKeypadInitialEvent(
    KeypadInitialEvent event,
    Emitter<KeypadState> emit,
  ) {
    emit(const KeypadInitial());
  }

  void _onKeypadNumberPressedEvent(
    KeypadNumberPressedEvent event,
    Emitter<KeypadState> emit,
  ) {
    if (state is KeypadInitial) {
      final currentState = state as KeypadInitial;
      String newCode = currentState.inputCode;

      // Giới hạn nhập tối đa 2 số
      if (newCode.length < 2) {
        newCode += event.number;
      }

      emit(currentState.copyWith(inputCode: newCode));
    }
  }

  void _onKeypadBackspacePressedEvent(
    KeypadBackspacePressedEvent event,
    Emitter<KeypadState> emit,
  ) {
    if (state is KeypadInitial) {
      final currentState = state as KeypadInitial;
      String newCode = currentState.inputCode;

      if (newCode.isNotEmpty) {
        newCode = newCode.substring(0, newCode.length - 1);
      }

      emit(currentState.copyWith(inputCode: newCode));
    }
  }

  void _onKeypadClearEvent(KeypadClearEvent event, Emitter<KeypadState> emit) {
    emit(const KeypadInitial());
  }

  void _onKeypadSubmitEvent(
    KeypadSubmitEvent event,
    Emitter<KeypadState> emit,
  ) async {
    if (state is KeypadInitial) {
      final currentState = state as KeypadInitial;
      final code = currentState.inputCode;

      if (code.isNotEmpty) {
        emit(KeypadSubmitting(inputCode: code));

        emit(KeypadSubmitted(inputCode: code));

        emit(const KeypadInitial(inputCode: ""));
      }
    } else if (state is KeypadSubmitted) {
      emit(const KeypadInitial(inputCode: ""));
    }
  }
}
