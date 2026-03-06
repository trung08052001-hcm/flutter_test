import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<HomeInitialEvent>(_onHomeInitialEvent);
    on<HomeTabChangedEvent>(_onHomeTabChangedEvent);
    on<HomeToggleLanguageEvent>(_onHomeToggleLanguageEvent);
    on<HomeCodeSubmittedEvent>(_onHomeCodeSubmittedEvent);
    on<HomeShowTourDetailEvent>(_onHomeShowTourDetailEvent);
    on<HomeCloseTourDetailEvent>(_onHomeCloseTourDetailEvent);
    on<HomeResetKeypadEvent>(_onHomeResetKeypadEvent);
  }

  void _onHomeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(const HomeInitial(selectedIndex: 0, showLanguageDialog: false));
  }

  void _onHomeTabChangedEvent(
    HomeTabChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeInitial) {
      final currentState = state as HomeInitial;
      emit(currentState.copyWith(selectedIndex: event.index));
    }
  }

  void _onHomeToggleLanguageEvent(
    HomeToggleLanguageEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeInitial) {
      final currentState = state as HomeInitial;
      emit(
        currentState.copyWith(
          showLanguageDialog: !currentState.showLanguageDialog,
        ),
      );
    }
  }

  void _onHomeCodeSubmittedEvent(
    HomeCodeSubmittedEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeInitial) {
      final currentState = state as HomeInitial;
      final isOdd = int.parse(event.code) % 2 != 0;
      emit(
        currentState.copyWith(
          submittedCode: event.code,
          showTourDetail: true,
          isOdd: isOdd,
        ),
      );
    }
  }

  void _onHomeShowTourDetailEvent(
    HomeShowTourDetailEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeInitial) {
      final currentState = state as HomeInitial;
      emit(
        currentState.copyWith(
          submittedCode: event.label,
          showTourDetail: true,
          isOdd: event.isOdd,
        ),
      );
    }
  }

  void _onHomeCloseTourDetailEvent(
    HomeCloseTourDetailEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeInitial) {
      final currentState = state as HomeInitial;
      emit(
        currentState.copyWith(
          showTourDetail: false,
          submittedCode: null,
          isOdd: null,
          resetKeypad: true,
        ),
      );
    }
  }

  void _onHomeResetKeypadEvent(
    HomeResetKeypadEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state is HomeInitial) {
      final currentState = state as HomeInitial;
      emit(currentState.copyWith(resetKeypad: false));
    }
  }
}
