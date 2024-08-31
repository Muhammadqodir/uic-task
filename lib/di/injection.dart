import 'package:audiobook_player/data/datasources/offline_datasource.dart';
import 'package:audiobook_player/data/datasources/online_datasource.dart';
import 'package:audiobook_player/data/repositories/audiotrack_repository_impl.dart';
import 'package:audiobook_player/domain/repositories/audiotrack_repository.dart';
import 'package:audiobook_player/domain/repositories/book_repository.dart';
import 'package:audiobook_player/domain/usecases/get_audiotracks.dart';
import 'package:audiobook_player/domain/usecases/get_books.dart';
import 'package:audiobook_player/presentation/bloc/audiotrack_bloc.dart';
import 'package:get_it/get_it.dart';
import '../data/repositories/book_repository_impl.dart';
import '../presentation/bloc/book_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  //DataSources
  getIt.registerLazySingleton<OnlineDataSource>(() => OnlineDataSource());
  getIt.registerLazySingleton<OfflineDataSource>(() => OfflineDataSource());

  //Repositories
  getIt.registerSingleton<BookRepository>(
    BookRepositoryImpl(
      onlineDataSource: getIt(),
      offlineDataSource: getIt(),
    ),
  );
  getIt.registerSingleton<AudiotrackRepository>(
    AudiotrackRepositoryImpl(
      onlineDataSource: getIt(),
      offlineDataSource: getIt(),
    ),
  );

  //Usecases
  getIt.registerSingleton<GetBooksUseCase>(GetBooksUseCase(
    getIt(),
  ));
  getIt.registerSingleton<GetAudioTracksUseCase>(GetAudioTracksUseCase(
    getIt(),
  ));

  //Bloc
  getIt.registerFactory<BookBloc>(
    () => BookBloc(getIt()),
  );
  getIt.registerFactory<AudiotrackBloc>(
    () => AudiotrackBloc(getIt()),
  );
}
