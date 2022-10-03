import 'package:flutter/material.dart';

import '../../common/error/user_error.dart';
import '../../common/params/no_params.dart';
import '../../common/params/note_params.dart';
import '../../data/database/database_helper.dart';
import '../../data/repository/note_repository_impl.dart';
import '../../domain/model/note_model.dart';
import '../../domain/usecase/delete_note_usecase.dart';
import '../../domain/usecase/get_all_note_usecase.dart';
import '../../domain/usecase/insert_note_usecase.dart';
import '../../domain/usecase/update_note_usecase.dart';

class NoteViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<NoteModel> _noteList = [];
  List<NoteModel> get noteList => _noteList;

  UserError? _userError;
  UserError? get userError => _userError;

  NoteModel? _selectedNote;
  NoteModel? get selectedNote => _selectedNote;

  NoteViewModel() {
    getAllNotes();
  }

  final InsertNoteUseCase _insertNoteUseCase = InsertNoteUseCase(
    noteRepository: NoteRepositoryImpl(databaseHelper: DatabaseHelper.instance),
  );

  final GetAllNoteUseCase _getAllNoteUseCase = GetAllNoteUseCase(
    noteRepository: NoteRepositoryImpl(databaseHelper: DatabaseHelper.instance),
  );

  final DeleteNoteUseCase _deleteNoteUseCase = DeleteNoteUseCase(
    noteRepository: NoteRepositoryImpl(databaseHelper: DatabaseHelper.instance),
  );

  final UpdateNoteUseCase _updateNoteUseCase = UpdateNoteUseCase(
    noteRepository: NoteRepositoryImpl(databaseHelper: DatabaseHelper.instance),
  );

  setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setNoteList(List<NoteModel> noteList) {
    _noteList = noteList;
  }

  insertNote(NoteModel note) async {
    setLoading(true);
    var response = await _insertNoteUseCase.call(NoteParams(note));
    refreshNoteListOrShowError(response);
    setLoading(false);
  }

  getAllNotes() async {
    setLoading(true);
    var response = await _getAllNoteUseCase.call(NoParams());
    refreshNoteListOrShowError(response);
    setLoading(false);
  }

  updateNote(NoteModel note) async {
    setLoading(true);
    var response = await _updateNoteUseCase.call(NoteParams(note));
    refreshNoteListOrShowError(response);
    setLoading(false);
  }

  deleteNote(NoteModel note) async {
    await _deleteNoteUseCase.call(NoteParams(note));
  }

  refreshNoteListOrShowError(dynamic response) {
    response.fold((l) {
      setUserError(UserError(errorMessage: l.errorMessage));
    }, (r) {
      if (r is List<NoteModel>) {
        setNoteList(r);
      } else {
        getAllNotes();
      }
    });
  }

  setSelectedNoteItem(NoteModel? noteModel) {
    _selectedNote = noteModel;
  }
}
