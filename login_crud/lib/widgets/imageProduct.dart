import 'dart:io';

import 'package:flutter/material.dart';

class ImageProduct extends StatelessWidget {
  final String? url;

  const ImageProduct({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: _tarjeta(),
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45)),
              child: getImage(url)),
        ),
      ),
    );
  }

  BoxDecoration _tarjeta() => BoxDecoration(
          color: Colors.black54,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]);

  Widget getImage(String? imagen) {
    /// muestra la imagen
    if (imagen == null) {
      return const Image(
        image: AssetImage('assets/fondo.png'),
        fit: BoxFit.cover,
      );
    }

    if (imagen.startsWith('http')) {
      return FadeInImage(
        placeholder: const AssetImage('assets/carga.gif'),
        image: NetworkImage(url!),
        fit: BoxFit.cover,
      );
    }

    return Image.file(
      File(imagen),
      fit: BoxFit.cover,
    );
  }
}
