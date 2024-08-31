// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_service/audio_service.dart';
import 'package:audiobook_player/core/audio_service.dart';
import 'package:audiobook_player/presentation/bloc/audio_player_bloc.dart';
import 'package:audiobook_player/presentation/bloc/audiotrack_bloc.dart';
import 'package:audiobook_player/presentation/widgets/audioplayer/audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/injection.dart';
import 'presentation/bloc/book_bloc.dart';
import 'presentation/pages/book_list_page.dart';

void main() async {
  await initializeDependencies();
  MyAudioHandler _myAudioHandler = await _initAudioService();
  runApp(MyApp(
    audioHandler: _myAudioHandler,
  ));
}

Future<MyAudioHandler> _initAudioService() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'uz.uictask.audiobook',
      androidNotificationChannelName: 'AudioBook',
      androidNotificationOngoing: true,
    ),
  );
}

class MyApp extends StatelessWidget {
  final MyAudioHandler audioHandler;
  const MyApp({
    Key? key,
    required this.audioHandler,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BookBloc>(
          create: (_) => getIt<BookBloc>()..add(const GetBooksEvent()),
        ),
        BlocProvider<AudiotrackBloc>(
          create: (_) => getIt<AudiotrackBloc>(),
        ),
        BlocProvider<AudioPlayerBloc>(
          create: (_) => AudioPlayerBloc(audioHandler),
        ),
      ],
      child: MaterialApp(
        title: 'Audiobook Player',
        home: BookListPage(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Stack(
            children: [
              child!,
              const Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: AudioPlayerWidget(),
              ),
            ],
          );
        },
      ),
    );
  }
}
