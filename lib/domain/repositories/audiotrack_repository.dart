import 'package:audiobook_player/core/res/datastate.dart';
import 'package:audiobook_player/domain/entities/audiotrack_entity.dart';
import 'package:audiobook_player/domain/entities/book_entity.dart';

abstract class AudiotrackRepository {
  Future<DataState<List<AudiotrackEntity>>> getAudioTrackList(BookEntity book);

  Future<void> saveAudioTracks(
    List<AudiotrackEntity> tracks,
    Function onProgress,
  );
}
