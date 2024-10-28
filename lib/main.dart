import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/app.dart';
import 'package:shopping_app_flutter/provider/cart_items_provider.dart';
import 'package:shopping_app_flutter/provider/product_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartItemsProvider()),
      ],
      child: const ShoppingApp(),
    ),
  );
}
