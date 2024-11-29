// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/utilities/decoration.dart';
import 'package:note_app/utilities/fonts_dart.dart';

class NoteWidget extends StatelessWidget {
  NotesModel notes;
  NoteWidget({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 120,
      decoration: noteContainerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(notes.headline, style: AppFonts.textW24bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Image.network(
                    notes.imageUrl.toString(),
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 150,
                  child: Expanded(
                    child: Text(
                      notes.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.textG14bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  "${notes.time.hour}:${notes.time.minute}${notes.time.hour >= 12 ? "  Pm" : "  Am"}"
                      .toString(),
                  style: AppFonts.textG14bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
