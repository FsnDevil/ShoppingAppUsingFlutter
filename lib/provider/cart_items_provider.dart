import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/models/product_model.dart';

class CartItemsProvider with ChangeNotifier {
  final List<Product> _listOfProducts = [];

  List<Product> get listOfProducts => _listOfProducts;

  void addProductIntoCart(Product product) {
    _listOfProducts.add(product);
  }

  void removeProductFromCart(Product product){
    _listOfProducts.remove(product);
  }
}
