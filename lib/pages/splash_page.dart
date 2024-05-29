import 'package:audiobook/cubit/books_cubit.dart';
import 'package:audiobook/pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    runApp();
  }

  void runApp() async {
    await context.read<BooksCubit>().getData(context);
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => const MainPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.book,
                size: 64,
              ),
              Text(
                "AudioBook",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              const CupertinoActivityIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
