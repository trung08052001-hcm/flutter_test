import 'package:equatable/equatable.dart';

abstract class TourDetailEvent extends Equatable {
  const TourDetailEvent();

  @override
  List<Object?> get props => [];
}

class TourDetailInitializeEvent extends TourDetailEvent {
  final String audioFile;
  const TourDetailInitializeEvent(this.audioFile);

  @override
  List<Object?> get props => [audioFile];
}

class TourDetailPlayPauseEvent extends TourDetailEvent {}

class TourDetailSeekEvent extends TourDetailEvent {
  final Duration position;
  const TourDetailSeekEvent(this.position);

  @override
  List<Object?> get props => [position];
}

class TourDetailDurationChangedEvent extends TourDetailEvent {
  final Duration duration;
  const TourDetailDurationChangedEvent(this.duration);

  @override
  List<Object?> get props => [duration];
}

class TourDetailPositionChangedEvent extends TourDetailEvent {
  final Duration position;
  const TourDetailPositionChangedEvent(this.position);

  @override
  List<Object?> get props => [position];
}

class TourDetailPlayerStateChangedEvent extends TourDetailEvent {
  final bool isPlaying;
  const TourDetailPlayerStateChangedEvent(this.isPlaying);

  @override
  List<Object?> get props => [isPlaying];
}

class TourDetailPlayerCompleteEvent extends TourDetailEvent {}
