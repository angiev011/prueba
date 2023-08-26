import 'package:flutter/material.dart';

class NotificacionesService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String mensaje) {
    final snackBar = SnackBar(
      content: Text(mensaje,
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
