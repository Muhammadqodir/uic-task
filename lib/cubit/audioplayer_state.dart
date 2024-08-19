// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audioplayer_cubit.dart';

class AudioplayerState {
  final MyAudioHandler audioHandler;

  AudioplayerState({
    required this.audioHandler,
  });

  AudioplayerState copyWith({
    MyAudioHandler? audioHandler,
  }) {
    return AudioplayerState(
      audioHandler: audioHandler ?? this.audioHandler,
    );
  }
}
