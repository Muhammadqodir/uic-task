import 'package:audiobook_player/domain/entities/book_entity.dart';
import 'package:audiobook_player/domain/usecases/get_books.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetBooksUseCase _getBooksUseCase;

  BookBloc(this._getBooksUseCase) : super(BookInitial()) {
    on<GetBooksEvent>(onGetBooks);
  }

  Future<void> onGetBooks(GetBooksEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    try {
      final books = await _getBooksUseCase();
      if (books.isSuccess) {
        emit(BookLoaded(books.data!));
      } else {
        BookError(books.message ?? "undefined error");
      }
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }
}
