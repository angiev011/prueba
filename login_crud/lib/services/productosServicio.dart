import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl = 'crudprueba-8ba10-default-rtdb.firebaseio.com';
  late ProductModel ProductoSeleccionado;

  List<ProductModel> productos = [];

  final storage = const FlutterSecureStorage();

  bool isLoading = true;
  bool isSave = false;

  ////////// ç¡
  // ignore: non_constant_identifier_names
  File? nuevaImagenArchivo;

  //// cuando yo llame el servicio y apenas se cree llame la instancia
  ProductService() {
    cargarProductos();
  }
  ///// Se cargue una lista de los productos <List<ProductModel>>
  Future<List<ProductModel>> cargarProductos() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'producto.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final rep = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(rep.body);

    productsMap.forEach((key, value) {
      final temporalProduct = ProductModel.fromMap(value);
      temporalProduct.id = key;
      productos.add(temporalProduct);
    });

    isLoading = false;
    notifyListeners();

    return productos;
  }

  Future guardarProducto(ProductModel productoGuardar) async {
    isSave = true;
    notifyListeners();

    if (productoGuardar.id == null) {
      // es necesario crear
      await crearProducto(productoGuardar);
    } else {
      //actualizar
      await actualizarProducto(productoGuardar);
    }

    isSave = false;
    notifyListeners();
  }

// preticion al backend
//actualizacion base de datos
  Future<String> actualizarProducto(ProductModel producto) async {
    final url = Uri.https(_baseUrl, '/producto/${producto.id}',
        {'auth': await storage.read(key: 'token') ?? ''});
    final rep = await http.put(url, body: producto.toJson());
    //final decodeData = rep.body;

    //actualizar el listado de productos
    final index = productos.indexWhere((element) => element.id == producto.id);
    productos[index] = producto;

    return producto.id!;
  }

  Future<String?> EliminarProducto(ProductModel producto) async {
    final url = Uri.https(_baseUrl, 'producto/${producto.id}.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final rep = await http.delete(url);

    if (rep.statusCode == 200) {
      print('Element deleted successfully.');
    } else {
      print('Failed to delete element. Status code: ${rep.statusCode}');
    }
  }

  Future<String?> crearProducto(ProductModel producto) async {
    final url = Uri.https(_baseUrl, 'producto.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final rep = await http.post(url, body: producto.toJson());
    final decodeData = json.decode(rep.body);
    // le asigno el id al producto
    producto.id = decodeData['nombre'];
    productos.add(producto);
    return producto.id;
  }

  void actualizarProductoImagen(String path) {
    ProductoSeleccionado.imagen = path;
    nuevaImagenArchivo = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> SubirImagen() async {
    if (nuevaImagenArchivo == null) return null;
    isSave = true;
    notifyListeners();
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dvo5qvife/image/upload?upload_preset=nk7vbctj');

    final cargarImagen = http.MultipartRequest('POST', url);
    final archivo =
        await http.MultipartFile.fromPath('file', nuevaImagenArchivo!.path);

    cargarImagen.files.add(archivo);
    final envioStream = await cargarImagen.send();
    final resp = await http.Response.fromStream(envioStream);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      return null;
    }

    nuevaImagenArchivo = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
