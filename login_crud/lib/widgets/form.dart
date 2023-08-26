import 'package:flutter/material.dart';

class FormCard extends StatelessWidget {
  const FormCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: _cardLogin(),
        child: this.child,
      ),
    );
  }

  BoxDecoration _cardLogin() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                // borde gris para el fondo del recuadro
                offset: Offset(0, 5))
          ]);
}
