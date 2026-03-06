import 'package:equatable/equatable.dart';

abstract class KeypadEvent extends Equatable {
  const KeypadEvent();

  @override
  List<Object?> get props => [];
}

class KeypadInitialEvent extends KeypadEvent {}

class KeypadNumberPressedEvent extends KeypadEvent {
  final String number;
  const KeypadNumberPressedEvent(this.number);

  @override
  List<Object?> get props => [number];
}

class KeypadBackspacePressedEvent extends KeypadEvent {}

class KeypadClearEvent extends KeypadEvent {}

class KeypadSubmitEvent extends KeypadEvent {}
