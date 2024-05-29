import 'package:audiobook/cubit/books_cubit.dart';
import 'package:audiobook/layouts/list_layout.dart';
import 'package:audiobook/pages/book_page.dart';
import 'package:audiobook/widgets/audio_book.dart';
import 'package:audiobook/widgets/cross_list_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    BooksState state = context.watch<BooksCubit>().state;
    return ListLayout(
      body: state.isLoading
          ? const Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                CupertinoActivityIndicator()
              ],
            )
          : Column(
              children: state.list
                  .map(
                    (e) => CrossListElement(
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => BookPage(book: e),
                          ),
                        );
                      },
                      child: AudioBookWidget(
                        book: e,
                      ),
                    ),
                  )
                  .toList(),
            ),
      title: "AudioBook",
    );
  }
}
