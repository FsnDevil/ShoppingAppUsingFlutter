import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/components/home_screen_cmp.dart';
import 'package:shopping_app_flutter/provider/product_provider.dart';
import 'package:shopping_app_flutter/screens/cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final List<Widget> screens = const [HomeScreenCmp(), CartScreen()];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: screens[productProvider.currentPage],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            productProvider.setCurrentPage(value);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          ]),
    );
  }
}
