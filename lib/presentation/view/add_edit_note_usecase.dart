import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/components/save_button.dart';
import '../../common/components/text_input_component.dart';
import '../../common/constants/string_constants.dart';
import '../../domain/model/note_model.dart';
import '../../navigation_utils.dart';
import '../viewmodel/note_viewmodel.dart';

class AddEditNoteScreen extends StatelessWidget {
  AddEditNoteScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  String _noteTitle = '';
  String _noteDesc = '';
  String _noteId = '';
  NoteModel? _selectedNote;

  @override
  Widget build(BuildContext context) {
    NoteViewModel noteViewModel = context.watch<NoteViewModel>();
    _selectedNote = noteViewModel.selectedNote;
    setNoteData();
    return Scaffold(
      appBar: AppBar(
        title:
            _selectedNote == null ? const Text(addNote) : const Text(editNote),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildNoteIdInput(),
            _buildTitleInput(),
            _buildDescriptionInput(),
            _buildSaveButton(noteViewModel, context),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteIdInput() {
    return TextInputComponent(
      onInputSaved: (input) {
        _noteId = input;
      },
      textInputType: TextInputType.number,
      inputTitle: noteId,
      inputError: enterNoteId,
      noteData: _selectedNote?.id.toString(),
      isEnabled: _selectedNote == null ? true : false,
    );
  }

  Widget _buildTitleInput() {
    return TextInputComponent(
        onInputSaved: (input) {
          _noteTitle = input;
        },
        inputTitle: noteTitle,
        inputError: enterNoteTitle,
        noteData: _selectedNote?.title.toString());
  }

  Widget _buildDescriptionInput() {
    return TextInputComponent(
        onInputSaved: (input) {
          _noteDesc = input;
        },
        inputTitle: noteDescription,
        inputError: enterNoteDescription,
        noteData: _selectedNote?.description.toString());
  }

  Widget _buildSaveButton(NoteViewModel noteViewModel, BuildContext context) {
    return SaveButton(
      onBtnTap: () {
        if (_formKey.currentState!.validate()) {
          _selectedNote == null
              ? noteViewModel.insertNote(
                  NoteModel(
                    id: int.parse(_noteId),
                    title: _noteTitle,
                    description: _noteDesc,
                    isEdited: false,
                  ),
                )
              : noteViewModel.updateNote(
                  NoteModel(
                    id: int.parse(_noteId),
                    title: _noteTitle,
                    description: _noteDesc,
                    isEdited: true,
                  ),
                );
          closeAddNoteScreen(context);
        }
      },
      btnText: _selectedNote == null ? addNote : editNote,
    );
  }

  void setNoteData() {
    if (_selectedNote == null) {
      return;
    }
    _noteId = _selectedNote!.id.toString();
    _noteTitle = _selectedNote!.title!;
    _noteDesc = _selectedNote!.description!;
  }
}
