import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'tour_detail_event.dart';
import 'tour_detail_state.dart';

class TourDetailBloc extends Bloc<TourDetailEvent, TourDetailState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _stateSubscription;
  StreamSubscription? _completeSubscription;
  String _currentAudioFile = '';

  TourDetailBloc() : super(TourDetailInitial()) {
    on<TourDetailInitializeEvent>(_onInitialize);
    on<TourDetailPlayPauseEvent>(_onPlayPause);
    on<TourDetailSeekEvent>(_onSeek);
    on<TourDetailDurationChangedEvent>(_onDurationChanged);
    on<TourDetailPositionChangedEvent>(_onPositionChanged);
    on<TourDetailPlayerStateChangedEvent>(_onPlayerStateChanged);
    on<TourDetailPlayerCompleteEvent>(_onPlayerComplete);
  }

  Future<void> _onInitialize(
    TourDetailInitializeEvent event,
    Emitter<TourDetailState> emit,
  ) async {
    emit(TourDetailLoading());

    _currentAudioFile = event.audioFile;

    try {
      // Cancel existing subscriptions
      await _cancelSubscriptions();

      // Setup new listeners
      _setupListeners();

      // Pre-load audio
      await _audioPlayer.setSource(AssetSource(event.audioFile));

      emit(TourDetailReady(audioFile: event.audioFile));
    } catch (e) {
      emit(TourDetailError(e.toString()));
    }
  }

  void _setupListeners() {
    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      add(TourDetailDurationChangedEvent(duration));
    });

    _positionSubscription = _audioPlayer.onPositionChanged.listen((position) {
      add(TourDetailPositionChangedEvent(position));
    });

    _stateSubscription = _audioPlayer.onPlayerStateChanged.listen((
      playerState,
    ) {
      add(
        TourDetailPlayerStateChangedEvent(playerState == PlayerState.playing),
      );
    });

    _completeSubscription = _audioPlayer.onPlayerComplete.listen((_) {
      add(TourDetailPlayerCompleteEvent());
    });
  }

  Future<void> _cancelSubscriptions() async {
    await _durationSubscription?.cancel();
    await _positionSubscription?.cancel();
    await _stateSubscription?.cancel();
    await _completeSubscription?.cancel();
  }

  Future<void> _onPlayPause(
    TourDetailPlayPauseEvent event,
    Emitter<TourDetailState> emit,
  ) async {
    if (state is TourDetailReady) {
      final currentState = state as TourDetailReady;

      try {
        if (currentState.isPlaying) {
          await _audioPlayer.pause();
        } else {
          await _audioPlayer.play(AssetSource(_currentAudioFile));
        }
      } catch (e) {
        emit(TourDetailError(e.toString()));
      }
    }
  }

  Future<void> _onSeek(
    TourDetailSeekEvent event,
    Emitter<TourDetailState> emit,
  ) async {
    if (state is TourDetailReady) {
      try {
        await _audioPlayer.seek(event.position);
      } catch (e) {
        emit(TourDetailError(e.toString()));
      }
    }
  }

  void _onDurationChanged(
    TourDetailDurationChangedEvent event,
    Emitter<TourDetailState> emit,
  ) {
    if (state is TourDetailReady) {
      final currentState = state as TourDetailReady;
      emit(currentState.copyWith(duration: event.duration));
    }
  }

  void _onPositionChanged(
    TourDetailPositionChangedEvent event,
    Emitter<TourDetailState> emit,
  ) {
    if (state is TourDetailReady) {
      final currentState = state as TourDetailReady;
      emit(currentState.copyWith(position: event.position));
    }
  }

  void _onPlayerStateChanged(
    TourDetailPlayerStateChangedEvent event,
    Emitter<TourDetailState> emit,
  ) {
    if (state is TourDetailReady) {
      final currentState = state as TourDetailReady;
      emit(currentState.copyWith(isPlaying: event.isPlaying));
    }
  }

  void _onPlayerComplete(
    TourDetailPlayerCompleteEvent event,
    Emitter<TourDetailState> emit,
  ) {
    if (state is TourDetailReady) {
      final currentState = state as TourDetailReady;
      emit(currentState.copyWith(isPlaying: false, position: Duration.zero));
    }
  }

  @override
  Future<void> close() async {
    await _cancelSubscriptions();
    await _audioPlayer.dispose();
    return super.close();
  }
}
