import 'package:flutter/material.dart';
import 'package:login_crud/models/models.dart';

class ProductosProviderForm extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProductModel product;

  ProductosProviderForm(this.product);

  updateDisponible(bool value) {
    product.disponible = value;
    notifyListeners();
  }

  bool isValidForm() {
    //si el estado regresa nulo entonces sera false
    return formKey.currentState?.validate() ?? false;
  }
}
