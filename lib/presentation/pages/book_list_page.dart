import 'package:audiobook_player/presentation/bloc/audiotrack_bloc.dart';
import 'package:audiobook_player/presentation/pages/audiotrack_list_page.dart';
import 'package:audiobook_player/presentation/widgets/book/book_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/book_bloc.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audiobooks')),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BookLoaded) {
            return ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];
                return BookTileWidget(
                  book: book,
                  onTap: () {
                    context.read<AudiotrackBloc>().add(
                          GetAudiotracksEvent(
                            bookEntity: book,
                          ),
                        );
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => AudiotrackListPage(
                          bookEntity: book,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is BookError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
