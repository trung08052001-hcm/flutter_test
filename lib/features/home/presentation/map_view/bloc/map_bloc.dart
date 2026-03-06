import 'package:flutter_bloc/flutter_bloc.dart';
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial(floors: MapInitial.getDefaultFloors())) {
    on<MapInitialEvent>(_onMapInitialEvent);
    on<MapFloorChangedEvent>(_onMapFloorChangedEvent);
    on<MapPoiTappedEvent>(_onMapPoiTappedEvent);
    on<MapScaleChangedEvent>(_onMapScaleChangedEvent);
  }

  void _onMapInitialEvent(MapInitialEvent event, Emitter<MapState> emit) {
    emit(MapInitial(floors: MapInitial.getDefaultFloors()));
  }

  void _onMapFloorChangedEvent(
    MapFloorChangedEvent event,
    Emitter<MapState> emit,
  ) {
    if (state is MapInitial) {
      final currentState = state as MapInitial;
      emit(
        currentState.copyWith(
          selectedFloorIndex: event.floorIndex,
          currentScale: 1.0,
        ),
      );
    }
  }

  void _onMapPoiTappedEvent(MapPoiTappedEvent event, Emitter<MapState> emit) {
    // POI tap is handled by the callback in UI
    // This event can be used for logging or analytics if needed
  }

  void _onMapScaleChangedEvent(
    MapScaleChangedEvent event,
    Emitter<MapState> emit,
  ) {
    if (state is MapInitial) {
      final currentState = state as MapInitial;
      emit(currentState.copyWith(currentScale: event.scale));
    }
  }
}
