import 'package:dartz/dartz.dart';

import '../../common/error/failure.dart';
import '../../common/params/note_params.dart';
import '../../common/usecase/usecase.dart';
import '../repository/note_repository.dart';

class UpdateNoteUseCase extends UseCase<int, NoteParams> {
  final NoteRepository _noteRepository;

  UpdateNoteUseCase({required NoteRepository noteRepository})
      : _noteRepository = noteRepository;

  @override
  Future<Either<Failure, int>> call(NoteParams params) async {
    return await _noteRepository.updateNote(params.note);
  }
}
