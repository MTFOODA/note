import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/logics/get_note_logic/state.dart';
import 'package:note_app/models/note_model.dart';

class GetNoteCubit extends Cubit<GetNotesState> {
  GetNoteCubit() : super(GetNoteInitialState());

  /// Get Notes
  Future getNotes() async {
    emit(GetNoteLoadingState());

    try {
      final getData =
          await FirebaseFirestore.instance.collection("notes").get();
      final notes =
          getData.docs.map((doc) => NotesModel.fromMap(doc.data())).toList();
      emit(GetNoteSuccessState(notes));
    } catch (e) {
      emit(GetNoteErrorState(e.toString()));
    }
  }
}
