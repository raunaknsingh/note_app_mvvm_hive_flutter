import 'package:flutter/material.dart';
import 'package:note_app_hive_flutter/presentation/view/add_edit_note_usecase.dart';

void openAddNoteScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddEditNoteScreen(),
    ),
  );
}

void closeAddNoteScreen(BuildContext context) {
  Navigator.pop(context);
}
