import 'package:hive/hive.dart';
import 'package:note_app_hive_flutter/data/model/note_entity.dart';

class Boxes {
  static Box<NoteEntity> getNotesBox() => Hive.box<NoteEntity>('note_entity');
}
