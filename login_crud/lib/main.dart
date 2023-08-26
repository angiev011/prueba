import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_crud/screens/screens.dart';
import 'package:login_crud/services/notificacionesServicio.dart';
import 'package:login_crud/services/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => AutenticarServices()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: LoginScreen.routerName,
      theme: ThemeData(
///// para que todos los widgets queden de desing 3
        useMaterial3: true,
// color global la aplicacion se acopla a una paleta de colores
      ),
      routes: {
        HomeScreen.routerName: (_) => const HomeScreen(),
        ProductosScreen.routerName: (_) => ProductosScreen(),
        LoginScreen.routerName: (_) => const LoginScreen(),
        RegistrarScreen.routerName: (_) => const RegistrarScreen(),
        ValidarScreen.routerName: (_) => const ValidarScreen(),
      },
      scaffoldMessengerKey: NotificacionesService.messengerKey,
    );
  }
}
