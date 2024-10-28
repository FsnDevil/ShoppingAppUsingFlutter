import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
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
                widget.product.image,
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
                  onPressed: () {},
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
