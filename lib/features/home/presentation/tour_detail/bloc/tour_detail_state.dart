import 'package:equatable/equatable.dart';

abstract class TourDetailState extends Equatable {
  const TourDetailState();

  @override
  List<Object?> get props => [];
}

class TourDetailInitial extends TourDetailState {}

class TourDetailLoading extends TourDetailState {}

class TourDetailReady extends TourDetailState {
  final bool isPlaying;
  final Duration duration;
  final Duration position;
  final String audioFile;

  const TourDetailReady({
    this.isPlaying = false,
    this.duration = Duration.zero,
    this.position = Duration.zero,
    this.audioFile = '',
  });

  @override
  List<Object?> get props => [isPlaying, duration, position, audioFile];

  TourDetailReady copyWith({
    bool? isPlaying,
    Duration? duration,
    Duration? position,
    String? audioFile,
  }) {
    return TourDetailReady(
      isPlaying: isPlaying ?? this.isPlaying,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      audioFile: audioFile ?? this.audioFile,
    );
  }
}

class TourDetailError extends TourDetailState {
  final String message;

  const TourDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
