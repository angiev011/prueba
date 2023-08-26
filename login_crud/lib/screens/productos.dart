import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_crud/provider/providerProductos.dart';
import 'package:login_crud/services/services.dart';
import 'package:login_crud/ui/inputs.dart';
import 'package:login_crud/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProductosScreen extends StatelessWidget {
  static String routerName = 'productos';

  const ProductosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
      create: (_) =>
          ProductosProviderForm(productsService.ProductoSeleccionado),
      child: _ProductsScreenBody(productsService: productsService),
    );

    // return _ProductsScreenBody(productsService: productsService);
  }
}

class _ProductsScreenBody extends StatelessWidget {
  const _ProductsScreenBody({
    required this.productsService,
  });

  final ProductService productsService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductosProviderForm>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ImageProduct(url: productsService.ProductoSeleccionado.imagen),

                /// BOTON IR HACIA ATRAS
                Positioned(
                    left: 20,
                    top: 60,
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 40,
                          color: Colors.white,
                        ))),

                ///BOTON ABRIR CAMARA O GALERIA
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              TextButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(150, 60)),
                      side:
                          MaterialStateProperty.all(const BorderSide(width: 1)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey.shade100),
                      enableFeedback: true,
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () async {
                    ///////obtener link de la imagen generada
                    final seleccionado = ImagePicker();
                    final XFile? archivoSeleccionado =
                        await seleccionado.pickImage(
                            source: ImageSource.camera, imageQuality: 100);
                    if (archivoSeleccionado == null) {
                      return;
                    }
                    productsService
                        .actualizarProductoImagen(archivoSeleccionado.path);
                  },
                  child: const Text(
                    'Tomar Foto',
                    style: TextStyle(color: Colors.black87),
                  )),
              TextButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(150, 60)),
                      side:
                          MaterialStateProperty.all(const BorderSide(width: 1)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey.shade100),
                      enableFeedback: true,
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () async {
                    ///////obtener link de la imagen generada
                    final seleccionado = ImagePicker();
                    final XFile? archivoSeleccionado =
                        await seleccionado.pickImage(
                            source: ImageSource.gallery, imageQuality: 100);
                    if (archivoSeleccionado == null) {
                      return;
                    }
                    productsService
                        .actualizarProductoImagen(archivoSeleccionado.path);
                  },
                  child: const Text(
                    'Subir Foto',
                    style: TextStyle(color: Colors.black87),
                  )),
            ]),
            const SizedBox(
              height: 10,
            ),
            _FormularioCrea(),
            const SizedBox(height: 200)
          ],
        ),
      ),

      ///BOTON GUARDAR CAMBIOS O AGREGAR
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: productsService.isSave
            ? CircularProgressIndicator(color: Colors.white)
            : Icon(Icons.save_outlined),
        onPressed: productsService.isLoading
            ? null
            : () async {
                if (!productForm.isValidForm()) return;

                final String? imageUrl = await productsService.SubirImagen();

                if (imageUrl != null) productForm.product.imagen = imageUrl;

                await productsService.guardarProducto(productForm.product);
              },
      ),
    );
  }
}

class _FormularioCrea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /////////////////traigo los valores al formulario
    final productForm = Provider.of<ProductosProviderForm>(context);
    final producto = productForm.product;

    //////////////////////
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 280,
        decoration: _estiloForm(),
        child: Form(
            // con esto se guarda la informacion update
            autovalidateMode: AutovalidateMode.onUserInteraction,

            /// VALIDAR FORMULARIO
            key: productForm.formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: producto.nombre,
                  onChanged: (value) => producto.nombre = value,
                  validator: (value) {
                    // ignore: prefer_is_empty
                    if (value == null || value.length < 1) {
                      return 'el nombre es obligatorio';
                    }
                  },
                  decoration: InputDecorations.loginInputDecoration(
                    hintText: 'Nombre Del Producto',
                    labelText: 'Nombre:',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  initialValue: producto.precio.toString(),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  onChanged: (value) {
                    (double.tryParse(value) == null)
                        ? producto.precio = 0
                        : producto.precio = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.loginInputDecoration(
                      hintText: '\$150',
                      labelText: 'Precio Inicial a Subastar:'),
                ),
                const SizedBox(
                  height: 30,
                ),
                SwitchListTile.adaptive(
                  value: producto.disponible,
                  title: const Text('Disponible Para Subasta'),
                  activeColor: Colors.indigo,
                  onChanged: productForm.updateDisponible,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
    );
  }

  BoxDecoration _estiloForm() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);
}
