import 'package:audiobook_player/core/usecase/usercase.dart';
import 'package:audiobook_player/domain/repositories/book_repository.dart';

class SaveBookUseCase implements UseCase<void, List<dynamic>> {
  final BookRepository _repository;

  SaveBookUseCase(this._repository);

  @override
  Future<void> call({List<dynamic>? params}) async {
    await _repository.saveBook(params![0], params[1]);
  }
}
