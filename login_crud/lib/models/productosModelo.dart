import 'dart:convert';

class ProductModel {
  bool disponible;
  String? imagen;
  String nombre;
  double precio;
  String? id;

  ProductModel(
      {required this.disponible,
      this.imagen,
      required this.nombre,
      required this.precio,
      this.id});

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        disponible: json["disponible"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        precio: json["precio"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "disponible": disponible,
        "imagen": imagen,
        "nombre": nombre,
        "precio": precio,
      };
  ProductModel copy() => ProductModel(
      disponible: disponible,
      imagen: imagen,
      nombre: nombre,
      precio: precio,
      id: id);
}
