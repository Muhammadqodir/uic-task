import 'package:audio_service/audio_service.dart';
import 'package:audiobook/cubit/books_cubit.dart';
import 'package:audiobook/cubit/playlist_cubit.dart';
import 'package:audiobook/pages/splash_page.dart';
import 'package:audiobook/services/audio_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

MyAudioHandler _audioHandler = MyAudioHandler();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _audioHandler = await AudioService.init(
      builder: () => MyAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'uz.uictask.audiobook',
        androidNotificationChannelName: 'AudioBook',
        androidNotificationOngoing: true,
      ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BooksCubit(),
        ),
        BlocProvider(
          create: (context) => PlaylistCubit(handler: _audioHandler),
        ),
      ],
      child: MaterialApp(
        title: 'AudioBook',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
