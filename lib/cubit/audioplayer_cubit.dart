import 'package:audio_service/audio_service.dart';
import 'package:audiobook/services/audio_handler.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'audioplayer_state.dart';

class AudioplayerCubit extends Cubit<AudioplayerState> {
  AudioplayerCubit({required MyAudioHandler handler})
      : super(
          AudioplayerState(
            audioHandler: handler,
          ),
        );

  void setPlaylist(
    String bookId,
    String bookName,
    List<MediaItem> items, {
    int startPlaying = -1,
  }) {
    state.audioHandler.setBookId(bookId);
    state.audioHandler.setBookName(bookName);
    state.audioHandler.initTracks(traks: items);
    if (startPlaying > 0) {
      state.audioHandler.skipToQueueItem(startPlaying);
    }
  }
}
