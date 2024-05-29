// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'books_cubit.dart';

class BooksState {
  bool isLoading;
  List<AudioBook> list;
  BooksState({
    required this.list,
    this.isLoading = true,
  });

  BooksState copyWith({
    bool? isLoading,
    List<AudioBook>? list,
  }) {
    return BooksState(
      isLoading: isLoading ?? this.isLoading,
      list: list ?? this.list,
    );
  }
}
