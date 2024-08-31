import 'package:audiobook_player/core/res/datastate.dart';
import 'package:audiobook_player/domain/entities/book_entity.dart';

abstract class BookRepository {
  Future<DataState<List<BookEntity>>> getBooksList();

  Future<void> saveBook(BookEntity book, Function(double progress) onProgress);
}
