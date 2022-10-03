import 'package:dartz/dartz.dart';

import '../../common/constants/string_constants.dart';
import '../../common/error/failure.dart';
import '../../domain/model/note_model.dart';
import '../../domain/repository/note_repository.dart';
import '../database/database_helper.dart';

class NoteRepositoryImpl implements NoteRepository {
  DatabaseHelper databaseHelper;
  NoteRepositoryImpl({required this.databaseHelper});

  @override
  Future<Either<Failure, int>> deleteNote(int id) async {
    try {
      await databaseHelper.deleteNote(id);
      return const Right(success);
    } catch (e) {
      return const Left(Failure(errorMessage: deleteNoteError));
    }
  }

  @override
  Future<Either<Failure, List<NoteModel>>> getAllNotes() async {
    try {
      final result = await databaseHelper.readAllNotes();
      return Right(result
          .map((noteEntity) => NoteModel.fromNoteEntity(noteEntity))
          .toList());
    } catch (e) {
      return const Left(Failure(errorMessage: readAllNoteError));
    }
  }

  @override
  Future<Either<Failure, int>> insertNote(NoteModel? note) async {
    try {
      if (note == null) {
        return const Left(Failure(errorMessage: noteNullError));
      }
      await databaseHelper.insertNote(note.toNoteEntity(note));
      return const Right(success);
    } catch (e) {
      return const Left(Failure(errorMessage: insertNoteError));
    }
  }

  @override
  Future<Either<Failure, int>> updateNote(NoteModel note) async {
    try {
      await databaseHelper.updateNote(note.toNoteEntity(note));
      return const Right(success);
    } catch (e) {
      return const Left(Failure(errorMessage: updateNoteError));
    }
  }
}
