import 'package:equatable/equatable.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

class MapInitialEvent extends MapEvent {}

class MapFloorChangedEvent extends MapEvent {
  final int floorIndex;
  const MapFloorChangedEvent(this.floorIndex);

  @override
  List<Object?> get props => [floorIndex];
}

class MapPoiTappedEvent extends MapEvent {
  final String label;
  final String floorName;
  const MapPoiTappedEvent({required this.label, required this.floorName});

  @override
  List<Object?> get props => [label, floorName];
}

class MapScaleChangedEvent extends MapEvent {
  final double scale;
  const MapScaleChangedEvent(this.scale);

  @override
  List<Object?> get props => [scale];
}
