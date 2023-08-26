import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration loginInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? Preficon}) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Preficon != null
            ? Icon(
                Preficon,
                color: Colors.deepPurple,
              )
            : null);
  }
}
