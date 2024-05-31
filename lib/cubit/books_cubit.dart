import 'package:audiobook/api/api.dart';
import 'package:audiobook/models/book.dart';
import 'package:audiobook/utils/dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  BooksCubit() : super(BooksState(list: []));

  Future<void> getData(BuildContext context) async {
    setLoading(true);
    ApiResponse<List<AudioBook>> res = await Api().getBooksList();
    if (res.isSuccess) {
      emit(state.copyWith(list: res.data));
    } else {
      showErrorDialog(context, res.title, res.message);
    }
    setLoading(false);
  }

  void setOffileBooks(List<String> list) {
    emit(
      state.copyWith(
        downloadedBooks: list,
      ),
    );
  }

  void setLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }
}
