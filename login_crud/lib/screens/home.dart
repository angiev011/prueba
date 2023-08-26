import 'package:flutter/material.dart';
import 'package:login_crud/models/models.dart';
import 'package:login_crud/screens/screens.dart';
import 'package:login_crud/services/autenticarServicio.dart';
import 'package:login_crud/services/productosServicio.dart';
import 'package:login_crud/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routerName = 'Home';

  @override
  Widget build(BuildContext context) {
    final productosServicio = Provider.of<ProductService>(context);
    final autServicio = Provider.of<AutenticarServices>(context);

    if (productosServicio.isLoading) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Column(children: [
            IconButton(
                onPressed: () {
                  autServicio.logout();
                  Navigator.pushReplacementNamed(context, 'Login');
                },
                icon: const Icon(
                  Icons.login_outlined,
                )),
            const Text(
              'Cerrar Sesion',
              style: TextStyle(fontSize: 5, fontWeight: FontWeight.w700),
            ),
          ])
        ],
        title: const Text('Articulos de Subasta'),
        centerTitle: true,
      ),
      body: ListView.builder(
        //del tamaño de la base de datos
        itemCount: productosServicio.productos.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              productosServicio.ProductoSeleccionado =
                  productosServicio.productos[index].copy();
              Navigator.pushNamed(context, 'productos');
            },
            //////error al momento de importar los productos el item counto debe ser la cantidad
            child: ProductoCard(
              product: productosServicio.productos[index],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productosServicio.ProductoSeleccionado =
              ProductModel(disponible: false, nombre: '', precio: 0);
          Navigator.pushNamed(context, 'productos');
        },
      ),
    );
  }
}
