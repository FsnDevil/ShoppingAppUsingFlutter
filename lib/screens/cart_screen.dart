import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/models/product_model.dart';
import 'package:shopping_app_flutter/provider/cart_items_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItemsProvider = Provider.of<CartItemsProvider>(context);

    return Scaffold(
      body: Center(
        child: Text((cartItemsProvider.listOfProducts[0]).title),
      ),
    );
  }
}
