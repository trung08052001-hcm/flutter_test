import 'package:equatable/equatable.dart';

abstract class DresionEvent extends Equatable {
  const DresionEvent();

  @override
  List<Object?> get props => [];
}

class DresionInitialEvent extends DresionEvent {}
