import 'package:flutter/material.dart';

class Fondo extends StatelessWidget {
  const Fondo({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [const _moradoCaja(), const iconoArriba(), child],
      ),
    );
  }
}

class iconoArriba extends StatelessWidget {
  const iconoArriba({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(
          Icons.person_pin_rounded,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

class _moradoCaja extends StatelessWidget {
  const _moradoCaja({super.key});

  @override
  Widget build(BuildContext context) {
    //media query para  que tome un cierto porcentaje de ancho en la pantalla

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _moradoFondo(),
      child: Stack(
        children: const [
          Positioned(
            top: 90,
            left: 20,
            child: _Circulos(),
          ),
          Positioned(
            top: 60,
            left: 200,
            child: _Circulos(),
          ),
          Positioned(
            top: 200,
            left: 120,
            child: _Circulos(),
          ),
          Positioned(
            top: 250,
            left: 300,
            child: _Circulos(),
          ),
          Positioned(
            top: -120,
            left: 10,
            child: _Circulos(),
          ),
        ],
      ),
    );
  }

  BoxDecoration _moradoFondo() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(148, 9, 223, 0.485),
        Color.fromRGBO(90, 70, 178, 1)
      ]));
}

class _Circulos extends StatelessWidget {
  const _Circulos({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
