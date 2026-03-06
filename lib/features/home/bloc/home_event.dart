import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeInitialEvent extends HomeEvent {}

class HomeTabChangedEvent extends HomeEvent {
  final int index;
  const HomeTabChangedEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class HomeToggleLanguageEvent extends HomeEvent {}

class HomeCodeSubmittedEvent extends HomeEvent {
  final String code;
  const HomeCodeSubmittedEvent(this.code);

  @override
  List<Object?> get props => [code];
}

class HomeShowTourDetailEvent extends HomeEvent {
  final String label;
  final bool isOdd;
  const HomeShowTourDetailEvent({required this.label, required this.isOdd});

  @override
  List<Object?> get props => [label, isOdd];
}

class HomeCloseTourDetailEvent extends HomeEvent {}

class HomeResetKeypadEvent extends HomeEvent {}
