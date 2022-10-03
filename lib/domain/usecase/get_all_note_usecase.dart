import 'package:dartz/dartz.dart';

import '../../common/error/failure.dart';
import '../../common/params/no_params.dart';
import '../../common/usecase/usecase.dart';
import '../model/note_model.dart';
import '../repository/note_repository.dart';

class GetAllNoteUseCase extends UseCase<List<NoteModel>, NoParams> {
  final NoteRepository _noteRepository;

  GetAllNoteUseCase({required NoteRepository noteRepository})
      : _noteRepository = noteRepository;

  @override
  Future<Either<Failure, List<NoteModel>>> call(NoParams noParams) async {
    return await _noteRepository.getAllNotes();
  }
}
