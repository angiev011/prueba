import 'package:flutter/material.dart';
import 'package:login_crud/models/models.dart';

class ProductosProviderForm extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  ProductModel? product;

  ProductosProviderForm(this.product);

  updateDisponible(bool value) {
    print(value);
    product?.disponible = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(product?.nombre);
    print(product?.precio);
    print(product?.disponible);

    //si el estado regresa nulo entonces sera false
    return formKey.currentState?.validate() ?? false;
  }
}
