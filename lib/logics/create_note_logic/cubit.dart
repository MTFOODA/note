import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/logics/create_note_logic/state.dart';
import 'package:note_app/models/note_model.dart';

class CreateNoteCubit extends Cubit<CreateNoteStates> {
  CreateNoteCubit() : super(CreateNoteInitialStates());

  /// function to create note
  Future createNote(NotesModel notes) async {
    emit(CreateNoteLoadingStates());
    try {
      await FirebaseFirestore.instance.collection("notes").add(notes.toMap());

      emit(CreateNoteSuccessStates());
    } catch (e) {
      emit(CreateNoteErrorStates(e.toString()));
    }
  }
}
