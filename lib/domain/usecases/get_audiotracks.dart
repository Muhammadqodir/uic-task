import 'package:audiobook_player/core/res/datastate.dart';
import 'package:audiobook_player/core/usecase/usercase.dart';
import 'package:audiobook_player/domain/entities/audiotrack_entity.dart';
import 'package:audiobook_player/domain/entities/book_entity.dart';
import 'package:audiobook_player/domain/repositories/audiotrack_repository.dart';

class GetAudioTracksUseCase
    implements UseCase<DataState<List<AudiotrackEntity>>, BookEntity> {
  final AudiotrackRepository _audiotrackRepository;

  GetAudioTracksUseCase(this._audiotrackRepository);

  @override
  Future<DataState<List<AudiotrackEntity>>> call({BookEntity? params}) {
    return _audiotrackRepository.getAudioTrackList(params!);
  }
}
