import 'package:flutter/material.dart';
import 'package:login_crud/models/models.dart';
import 'package:login_crud/services/services.dart';
import 'package:login_crud/services/services.dart';
import 'package:provider/provider.dart';

class ProductoCard extends StatelessWidget {
  ProductoCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorde(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _fondoImagen(product.imagen),
            _detallesProducto(
              /////////argumentos
              nombre: product.nombre,
            ),
            Positioned(
                top: 0,
                right: 0,
                child: _flexArriba(
                  precio: product.precio,
                )),
            const Positioned(bottom: 0, right: 0, child: _ButtonDelete()),
            /////////////condicion para mostrar o no la etiqueta avalible
            if (!product.disponible)
              Positioned(top: 0, left: 0, child: _NoAvalible())
          ],
        ),
      ),
    );
  }

///////////////////////////////////////////////
  BoxDecoration _cardBorde() =>
      BoxDecoration(borderRadius: BorderRadius.circular(25), boxShadow: const [
        BoxShadow(color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
      ]);
}

class _arriba extends StatelessWidget {
  const _arriba({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _ButtonDelete extends StatelessWidget {
  const _ButtonDelete({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductService>(context);
    final scans = productsService.productos;

    return Container(
        width: 50,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(25))),
        child: IconButton(
            onPressed: () async {
              /// que va pasar cuando se presione el boton

              await productsService.EliminarProducto(scans.first);
            },
            icon: const Icon(color: Colors.black, Icons.delete_outline)));
  }
}
//////////////////////////////

class _NoAvalible extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25))),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Subastado',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class _flexArriba extends StatelessWidget {
  final double precio;

  const _flexArriba({super.key, required this.precio});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: const BorderRadius.only(topRight: Radius.circular(25))),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '$precio\$',
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////
class _detallesProducto extends StatelessWidget {
  final String nombre;

  const _detallesProducto({super.key, required this.nombre});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _descripcionDeco(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              //si se sale se utiliza el overflow
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _descripcionDeco() => BoxDecoration(
      color: Colors.deepPurple[100],
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25)));
}

/////////////////////////////////////////////////////

class _fondoImagen extends StatelessWidget {
  final String? url;

  const _fondoImagen(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
          width: double.infinity,
          height: 400,
          child: url == null
              ? const Image(
                  image: AssetImage('assets/fondo.png'), fit: BoxFit.cover)
              : FadeInImage(
                  placeholder: const AssetImage('assets/carga.gif'),
                  image: NetworkImage(url!),
                  //fit cuando la imagen no coge todo el espacio
                  fit: BoxFit.cover,
                )),
    );
  }
}
