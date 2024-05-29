import 'package:audiobook/cubit/books_cubit.dart';
import 'package:audiobook/cubit/playlist_cubit.dart';
import 'package:audiobook/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
          create: (context) => PlaylistCubit(),
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
