import 'package:audiobook_player/core/res/datastate.dart';
import 'package:audiobook_player/data/datasources/offline_datasource.dart';
import 'package:audiobook_player/data/datasources/online_datasource.dart';
import 'package:audiobook_player/data/models/audiotrack_model.dart';
import 'package:audiobook_player/domain/entities/audiotrack_entity.dart';
import 'package:audiobook_player/domain/entities/book_entity.dart';
import 'package:audiobook_player/domain/repositories/audiotrack_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AudiotrackRepositoryImpl implements AudiotrackRepository {
  final OnlineDataSource onlineDataSource;
  final OfflineDataSource offlineDataSource;

  AudiotrackRepositoryImpl({
    required this.onlineDataSource,
    required this.offlineDataSource,
  });

  @override
  Future<DataState<List<AudiotrackEntity>>> getAudioTrackList(
    BookEntity book,
  ) async {
    Map<String, dynamic> savedAudiotracks =
        await offlineDataSource.getSavedAudiotracks();
    DataState<List<AudiotrackModel>> models = await getAudiotrackModels(book);
    if (models.isSuccess) {
      List<AudiotrackEntity> list = [];
      for (var element in models.data!) {
        print(savedAudiotracks[element.listenUrl ?? "_undefined"]);
        list.add(
          element.toEntity(
            isDownloaded: savedAudiotracks.containsKey(
              element.listenUrl ?? "_undefined",
            ),
            localUrl: savedAudiotracks[element.listenUrl ?? "_undefined"],
          ),
        );
      }
      return DataState.success(data: list);
    } else {
      return DataState.error(message: models.message);
    }
  }

  Future<DataState<List<AudiotrackModel>>> getAudiotrackModels(
    BookEntity book,
  ) async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      try {
        DataState<List<AudiotrackModel>> books =
            await onlineDataSource.getAudioTracks(book.id);
        // Optionally save the books locally for offline access
        await offlineDataSource.cacheAudioTracks(
          book.id,
          books.isSuccess ? books.data! : [],
        );
        return books;
      } catch (e) {
        // If online fetch fails, fallback to offline data
        DataState<List<AudiotrackModel>> cachedBooks =
            await offlineDataSource.fetchAudiotracks(book.id);
        return cachedBooks;
      }
    } else {
      // If online fetch fails, fallback to offline data
      DataState<List<AudiotrackModel>> cachedBooks =
          await offlineDataSource.fetchAudiotracks(
        book.id,
      );
      return cachedBooks;
    }
  }

  @override
  Future<void> saveAudioTracks(
    List<AudiotrackEntity> tracks,
    Function onProgress,
  ) async {
    for (var element in tracks) {
      onProgress(tracks.indexOf(element));
      print(element.title);
    }
  }
}
