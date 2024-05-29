// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  AudioPlayer audioPlayer = AudioPlayer();
  String bookId;
  String bookName;
  MyAudioHandler({
    required this.bookId,
    this.bookName = "undefined",
  });

  void setBookId(String id) {
    bookId = id;
  }

  void setBookName(String name) {
    bookName = name;
  }

  UriAudioSource _createAudioSource(MediaItem item) {
    return ProgressiveAudioSource(Uri.parse(item.id));
  }

  void _listenForCurrentAudiotrackIndexChanges() {
    audioPlayer.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      mediaItem.add(playlist[index]);
    });
  }

  void _boardcastState(PlaybackEvent event) {
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[audioPlayer.processingState]!,
        playing: audioPlayer.playing,
        updatePosition: audioPlayer.position,
        bufferedPosition: audioPlayer.bufferedPosition,
        speed: audioPlayer.speed,
        queueIndex: audioPlayer.currentIndex,
      ),
    );
  }

  Future<void> initTracks({required List<MediaItem> traks}) async {
    audioPlayer.playbackEventStream.listen(_boardcastState);

    final audioSource = traks.map(_createAudioSource);

    await audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: audioSource.toList(),
      ),
    );

    final newQueue = queue.value..addAll(traks);
    queue.add(newQueue);

    _listenForCurrentAudiotrackIndexChanges();

    audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) skipToNext();
    });
  }

  @override
  Future<void> play() async => audioPlayer.play();

  @override
  Future<void> seek(Duration position) async => audioPlayer.seek(position);

  @override
  Future<void> pause() async => audioPlayer.pause();

  @override
  Future<void> skipToQueueItem(int index) async {
    await audioPlayer.seek(Duration.zero, index: index);
    play();
  }

  @override
  Future<void> skipToNext() async => audioPlayer.seekToNext();

  @override
  Future<void> skipToPrevious() async => audioPlayer.seekToPrevious();
}
