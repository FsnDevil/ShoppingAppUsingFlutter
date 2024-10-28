import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/models/product_model.dart';
import 'package:shopping_app_flutter/provider/cart_items_provider.dart';
import 'package:shopping_app_flutter/provider/product_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItemsProvider = Provider.of<CartItemsProvider>(context,listen: false);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Details",
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontFamily: 'suse'),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.network(
                productProvider.product.image,
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    cartItemsProvider.addProductIntoCart(productProvider.product);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      textStyle: const TextStyle(
                          fontFamily: 'suse', fontSize: 16, color: Colors.black)),
                  child: const Text("Add to cart"),
                ),
              ),
            ),
          ],
        ));
  }
}
