import 'package:dartz/dartz.dart';

import '../../common/error/failure.dart';
import '../model/note_model.dart';

abstract class NoteRepository {
  Future<Either<Failure, int>> insertNote(NoteModel? note);
  Future<Either<Failure, List<NoteModel>>> getAllNotes();
  Future<Either<Failure, int>> updateNote(NoteModel note);
  Future<Either<Failure, int>> deleteNote(int id);
}
