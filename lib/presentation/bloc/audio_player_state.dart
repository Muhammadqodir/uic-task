part of 'audio_player_bloc.dart';

@immutable
sealed class AudioPlayerState extends Equatable {
  const AudioPlayerState();

  @override
  List<Object> get props => [];
}

final class AudioPlayerInitial extends AudioPlayerState {}

class AudioPlayerLoading extends AudioPlayerState {}

class AudioPlayerLoaded extends AudioPlayerState {
  final List<AudiotrackEntity> audioTracks;
  final BookEntity book;

  const AudioPlayerLoaded({required this.audioTracks, required this.book});

  @override
  List<Object> get props => [
        audioTracks,
        book,
      ];
}

class AudioPlayerError extends AudioPlayerState {
  final String message;

  const AudioPlayerError(this.message);

  @override
  List<Object> get props => [message];
}
