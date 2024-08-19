// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'audioplayer_cubit.dart';

class AudioplayerState {
  final MyAudioHandler audioHandler;
  bool isLoading;

  AudioplayerState({
    required this.audioHandler,
    required this.isLoading,
  });

  AudioplayerState copyWith({
    MyAudioHandler? audioHandler,
    bool? isLoading,
  }) {
    return AudioplayerState(
      audioHandler: audioHandler ?? this.audioHandler,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
