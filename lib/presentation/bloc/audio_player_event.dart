part of 'audio_player_bloc.dart';

@immutable
sealed class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();

  @override
  List<Object> get props => [];
}

class AudiotrackTapEvent extends AudioPlayerEvent {
  final BookEntity bookEntity;
  final List<AudiotrackEntity> playlist;
  final int startPlayingIndex;

  const AudiotrackTapEvent({
    required this.bookEntity,
    required this.playlist,
    required this.startPlayingIndex,
  });
}

class InitPlaylistEvent extends AudioPlayerEvent {
  final BookEntity bookEntity;
  final List<AudiotrackEntity> playlist;
  final int startPlayingIndex;
  final int progress;
  const InitPlaylistEvent({
    required this.bookEntity,
    required this.playlist,
    this.startPlayingIndex = 0,
    this.progress = 0,
  });
}

class LoadLastPlayedEvent extends AudioPlayerEvent {
  const LoadLastPlayedEvent();
}

class SkipToIndexEvent extends AudioPlayerEvent {
  final int index;
  const SkipToIndexEvent({required this.index});
}
