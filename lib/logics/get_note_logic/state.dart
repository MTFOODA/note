import 'package:note_app/models/note_model.dart';

abstract class GetNotesState {}

class GetNoteInitialState extends GetNotesState {}

class GetNoteLoadingState extends GetNotesState {}

class GetNoteSuccessState extends GetNotesState {
  final List<NotesModel> notes;
  GetNoteSuccessState(this.notes);
}

class GetNoteErrorState extends GetNotesState {
  final String errorMessage;
  GetNoteErrorState(this.errorMessage);
}
