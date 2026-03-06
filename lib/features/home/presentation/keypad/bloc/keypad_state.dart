import 'package:equatable/equatable.dart';

abstract class KeypadState extends Equatable {
  const KeypadState();

  @override
  List<Object?> get props => [];
}

class KeypadInitial extends KeypadState {
  final String inputCode;

  const KeypadInitial({this.inputCode = ""});

  @override
  List<Object?> get props => [inputCode];

  KeypadInitial copyWith({String? inputCode}) {
    return KeypadInitial(inputCode: inputCode ?? this.inputCode);
  }
}

class KeypadSubmitting extends KeypadState {
  final String inputCode;

  const KeypadSubmitting({required this.inputCode});

  @override
  List<Object?> get props => [inputCode];
}

class KeypadSubmitted extends KeypadState {
  final String inputCode;

  const KeypadSubmitted({required this.inputCode});

  @override
  List<Object?> get props => [inputCode];
}
