import 'package:flutter/material.dart';
import 'package:login_crud/provider/providerLogin.dart';
import 'package:login_crud/services/notificacionesServicio.dart';
import 'package:login_crud/widgets/form.dart';
import 'package:login_crud/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';
import '../ui/inputs.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String routerName = 'Login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Fondo(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 220,
              ),
              FormCard(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Iniciar Sesion',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //////////CONECTO EL PROVEEDOR
                    ChangeNotifierProvider(
                      create: (_) => LoginProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.indigo.withOpacity(0.1)),
                      shape: MaterialStateProperty.all(const StadiumBorder())),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'Registrar'),
                  child: const Text('Registrarse',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87))),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ////////////////// importo clase proveedora
    final loginForm = Provider.of<LoginProvider>(context);
    return Form(
        /////utilizo llave unica del gestor
        key: loginForm.formKey,
        child: Column(
          children: [
            TextFormField(
              ///////// guarde los valores para poder mostrarlos en consola

              onChanged: (value) => loginForm.email = value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El correo es incorrecto';
              },
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.loginInputDecoration(
                  hintText: 'correo@gmail.com',
                  Preficon: Icons.alternate_email_sharp,
                  labelText: 'Correo Electronico'),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              /////////asignar valor al value
              onChanged: (value) => loginForm.password = value,

              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe ser de 6 caracteres';
              },
              autocorrect: false,
              //// constraseña
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.loginInputDecoration(
                  hintText: 'Mas de 6 caracteres',
                  Preficon: Icons.password_sharp,
                  labelText: 'Contraseña'),
            ),
            const SizedBox(height: 30),
            MaterialButton(
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              // si el formulario esta cargando osea es true desactivelo si no haga el resto
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      /////desactivar el boton
                      FocusScope.of(context).unfocus();
                      final autService = Provider.of<AutenticarServices>(
                          context,
                          listen: false);

                      /////// al presionar el boton valide
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;

                      ///validar login
                      final String? mensajeError = await autService.validar(
                          loginForm.email, loginForm.password);

                      if (mensajeError == null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, 'Home');
                      } else {
                        NotificacionesService.showSnackbar(
                            '[El Correo No Existe] [Registrese]');
                        loginForm.isLoading = false;
                      }
                    },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere..' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}
