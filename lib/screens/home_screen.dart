import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app_flutter/components/home_screen_cmp.dart';
import 'package:shopping_app_flutter/models/product_model.dart';
import 'package:shopping_app_flutter/screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  List<Widget> screens = const [HomeScreenCmp(), CartScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPage],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          ]),
    );
  }
}
