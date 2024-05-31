// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'books_cubit.dart';

class BooksState {
  bool isLoading;
  List<AudioBook> list;
  List<String> downloadedBooks;
  BooksState({
    required this.list,
    this.isLoading = true,
    this.downloadedBooks = const [],
  });

  BooksState copyWith({
    bool? isLoading,
    List<AudioBook>? list,
    List<String>? downloadedBooks,
  }) {
    return BooksState(
      isLoading: isLoading ?? this.isLoading,
      list: list ?? this.list,
      downloadedBooks: downloadedBooks ?? this.downloadedBooks,
    );
  }
}
