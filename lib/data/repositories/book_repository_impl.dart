import 'package:audiobook_player/core/res/datastate.dart';
import 'package:audiobook_player/data/datasources/offline_datasource.dart';
import 'package:audiobook_player/data/datasources/online_datasource.dart';
import 'package:audiobook_player/data/models/audiotrack_model.dart';
import 'package:audiobook_player/data/models/book_model.dart';
import 'package:audiobook_player/di/injection.dart';
import 'package:audiobook_player/domain/entities/book_entity.dart';
import 'package:audiobook_player/domain/repositories/audiotrack_repository.dart';
import 'package:audiobook_player/domain/repositories/book_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookRepositoryImpl implements BookRepository {
  final OnlineDataSource onlineDataSource;
  final OfflineDataSource offlineDataSource;

  BookRepositoryImpl({
    required this.onlineDataSource,
    required this.offlineDataSource,
  });

  @override
  Future<DataState<List<BookEntity>>> getBooksList() async {
    if ((await Connectivity().checkConnectivity()) != ConnectivityResult.none) {
      print("Online");
      try {
        DataState<List<BookModel>> books = await onlineDataSource.fetchBooks();
        // Optionally save the books locally for offline access
        await offlineDataSource.cacheBooks(books.isSuccess ? books.data! : []);
        return books.isSuccess
            ? DataState.success(
                data: books.data!.map((e) => e.toEntity()).toList(),
              )
            : DataState.success(data: []);
      } catch (e) {
        print("Offline");

        // If online fetch fails, fallback to offline data
        DataState<List<BookModel>> cachedBooks =
            await offlineDataSource.fetchBooks();
        return cachedBooks.isSuccess
            ? DataState.success(
                data: cachedBooks.data!.map((e) => e.toEntity()).toList())
            : DataState.success(data: []);
      }
    } else {
      print("Offline no internet");

      // If online fetch fails, fallback to offline data
      DataState<List<BookModel>> cachedBooks =
          await offlineDataSource.fetchBooks();
      return cachedBooks.isSuccess
          ? DataState.success(
              data: cachedBooks.data!.map((e) => e.toEntity()).toList())
          : DataState.success(data: []);
    }
  }

  @override
  Future<void> saveBook(
    BookEntity book,
    Function(double progress) onProgress,
  ) async {
    DataState<List<AudiotrackModel>> audiotracks =
        await onlineDataSource.getAudioTracks(
      book.id,
    );
    if (audiotracks.isSuccess) {
      print(audiotracks.data!.length);
      for (var element in audiotracks.data!) {
        print("next sycle");
        await offlineDataSource.downloadAudiotrack(element);
        onProgress(
          (audiotracks.data!.indexOf(element) + 1) / audiotracks.data!.length,
        );
      }
    }
  }
}
