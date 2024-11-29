import 'package:flutter/material.dart';
import 'package:note_app/utilities/colors_dart.dart';
import 'package:note_app/utilities/fonts_dart.dart';

InputDecoration customInputDecoration(String labelText) {
  return InputDecoration(
    fillColor: AppColors.lightPurple,
    filled: true,
    labelText: labelText,
    labelStyle: AppFonts.textW24bold,
    //
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    //
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    //
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
  );
}

// Function for Container decoration
BoxDecoration customContainerDecoration({
  Color color = AppColors.one,
  double borderRadius = 5.0,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(borderRadius),
  );
}

// Function for Container decoration
BoxDecoration noteContainerDecoration({
  Color color = AppColors.lightPurple,
  double borderRadius = 16.0,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(borderRadius),
  );
}
