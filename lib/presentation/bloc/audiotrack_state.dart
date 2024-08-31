part of 'audiotrack_bloc.dart';

@immutable
sealed class AudiotrackState extends Equatable {
  const AudiotrackState();

  @override
  List<Object> get props => [];
}

final class AudiotrackInitial extends AudiotrackState {}

class AudiotrackLoading extends AudiotrackState {}

class AudiotrackLoaded extends AudiotrackState {
  final List<AudiotrackEntity> audiotracks;

  const AudiotrackLoaded(this.audiotracks);

  @override
  List<Object> get props => [audiotracks];
}

class AudiotrackError extends AudiotrackState {
  final String message;

  const AudiotrackError(this.message);

  @override
  List<Object> get props => [message];
}
