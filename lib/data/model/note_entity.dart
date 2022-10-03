import 'package:hive/hive.dart';

part 'note_entity.g.dart';

@HiveType(typeId: 0)
class NoteEntity extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final bool isEdited;

  @HiveField(4)
  final String? createdDate;

  NoteEntity(
      {required this.id,
      required this.title,
      this.description,
      required this.isEdited,
      this.createdDate});

  Map<String, dynamic> toJson() => {
        NoteFields.columnId: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.isEdited: isEdited ? 1 : 0,
        NoteFields.date: createdDate
      };

  static NoteEntity fromJson(Map<String, dynamic> json) => NoteEntity(
      id: json[NoteFields.columnId],
      title: json[NoteFields.title],
      description: json[NoteFields.description],
      isEdited: json[NoteFields.isEdited] == 1,
      createdDate: json[NoteFields.date]);
}

class NoteFields {
  static const columnId = 'id';
  static const title = 'title';
  static const description = 'description';
  static const date = 'date';
  static const isEdited = 'isEdited';
}
