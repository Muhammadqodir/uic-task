import 'package:audiobook_player/core/res/datastate.dart';
import 'package:audiobook_player/core/usecase/usercase.dart';
import 'package:audiobook_player/domain/entities/book_entity.dart';
import 'package:audiobook_player/domain/repositories/book_repository.dart';

class GetBooksUseCase implements UseCase<DataState<List<BookEntity>>, void> {
  final BookRepository _repository;

  GetBooksUseCase(this._repository);

  @override
  Future<DataState<List<BookEntity>>> call({void params}) {
    return _repository.getBooksList();
  }
}
