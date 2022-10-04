import 'dart:async';

import '../model/note_entity.dart';
import 'boxes.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future insertNote(NoteEntity note) async {
    await Boxes.getNotesBox().put(note.id, note);
  }

  Future<List<NoteEntity>> readAllNotes() async {
    return Boxes.getNotesBox().values.toList().cast<NoteEntity>();
  }

  Future updateNote(NoteEntity note) async {
    Boxes.getNotesBox().put(note.id, note);
  }

  Future deleteNote(int id) async {
    Boxes.getNotesBox().delete(id);
  }
}
