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
        ) {
    _initAudioHandler();
  }

  MyAudioHandler _audioHandler = MyAudioHandler(bookId: "undefined");

  Future<void> _initAudioHandler() async {
    _audioHandler = await AudioService.init(
      builder: () => state.audioHandler,
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'uz.uictask.audiobook',
        androidNotificationChannelName: 'AudioBook',
        androidNotificationOngoing: true,
      ),
    );
  }

  void setPlaylist(
    String bookId,
    String bookName,
    List<MediaItem> items, {
    int startPlaying = -1,
    required Function onComplate,
  }) async {
    await state.audioHandler.stop();
    print("stop audio handler");
    state.audioHandler.setBookId(bookId);
    state.audioHandler.setBookName(bookName);
    await state.audioHandler.initTracks(traks: items);
    if (startPlaying > 0) {
      await state.audioHandler.skipToQueueItem(startPlaying);
    }
    emit(state);
    onComplate();
  }
}
