import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testt/features/splash/bloc/splash_event.dart';
import 'package:flutter_testt/features/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState.initial()) {
    on<StartSplashEvent>(_onStartSplash);
    on<NavigateToHomeEvent>(_onNavigateToHome);
    on<NavigateToDresionEvent>(_onNavigateToDresion);
  }

  void _onStartSplash(StartSplashEvent event, Emitter<SplashState> emit) {
    emit(state.copyWith(status: SplashStatus.initial));
  }

  void _onNavigateToHome(NavigateToHomeEvent event, Emitter<SplashState> emit) {
    emit(state.copyWith(status: SplashStatus.completed));
  }

  void _onNavigateToDresion(
    NavigateToDresionEvent event,
    Emitter<SplashState> emit,
  ) {
    emit(state.copyWith(status: SplashStatus.completed));
  }
}
