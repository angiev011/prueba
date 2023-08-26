import 'package:flutter/material.dart';
import 'package:login_crud/screens/screens.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class ValidarScreen extends StatelessWidget {
  const ValidarScreen({Key? key}) : super(key: key);
  static String routerName = 'Verificar';

  @override
  Widget build(BuildContext context) {
    final autServices = Provider.of<AutenticarServices>(context);
    return Scaffold(
        body: Center(
            child: FutureBuilder(
                future: autServices.LeerToken(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) return const Text('Cargando..');

                  if (!snapshot.hasData == '') {
                    Future.microtask(() {
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) => const LoginScreen(),
                              transitionDuration: const Duration(seconds: 0)));
                      //Navigator.of(context).pushReplacementNamed('Login');
                    });
                  } else {
                    Future.microtask(() {
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) => const HomeScreen(),
                              transitionDuration: const Duration(seconds: 0)));
                    });
                  }

                  return Container();
                })));
  }
}
