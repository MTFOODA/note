import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/logics/get_note_logic/cubit.dart';
import 'package:note_app/logics/get_note_logic/state.dart';
import 'package:note_app/screens/createNote_screen.dart';
import 'package:note_app/widgets/appBar.dart';
import 'package:note_app/widgets/note_widget.dart';
import 'package:note_app/utilities/colors_dart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetNoteCubit()..getNotes(),
      child: Scaffold(
        backgroundColor: AppColors.primaryLM,

        appBar: CustomAppBar(title: 'Notes'.tr()),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 70),
              BlocBuilder<GetNoteCubit, GetNotesState>(
                builder: (context, state) {
                  if (state is GetNoteLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetNoteSuccessState) {
                    final notes = state.notes;
                    return Column(
                      children: List.generate(
                        notes.length,
                            (index) {
                          final note = notes[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NoteWidget(notes: note),
                          );
                        },
                      ),
                    );
                  } else if (state is GetNoteErrorState) {
                    print(state.errorMessage);
                    return Center(
                        child: Text('Error: ${state.errorMessage}'));
                  } else {
                    return const Center(child: Text('No notes found'));
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateNoteScreen()),
            );
          },
          tooltip: 'Add Note'.tr(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
