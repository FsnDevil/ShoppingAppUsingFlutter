import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String _selectedCategory = "All";
  String _searchTerm = "";
  int _currentPage = 0;
  bool _isLoading = true;
  late Product _product;

  List<Product> get filteredProducts => _filteredProducts;

  List<String> get categories =>
      ["All", ..._products.map((p) => p.category).toSet()];

  String get selectedCategory => _selectedCategory;

  int get currentPage => _currentPage;

  bool get isLoading => _isLoading;

  Product get product => _product;

  ProductProvider() {
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      var response =
          await http.get(Uri.parse("https://fakestoreapi.com/products"));
      var productListData = jsonDecode(response.body) as List;
      _products =
          productListData.map((data) => Product.fromJson(data)).toList();
      _filteredProducts = _products; // Initially show all products
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception("Failed to fetch products: $e");
    }
  }

  void passProductToProductDetailsScreen(Product product){
    _product = product;
  }

  void setCurrentPage(int pageNumber) {
    _currentPage = pageNumber;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    _filterProducts();
    notifyListeners();
  }

  void setSearchTerm(String term) {
    _searchTerm = term;
    _filterProducts();
    notifyListeners();
  }

  void _filterProducts() {
    _filteredProducts = _products.where((product) {
      final matchesSearch = _searchTerm.isEmpty ||
          product.title.toLowerCase().contains(_searchTerm.toLowerCase()) ||
          product.description.toLowerCase().contains(_searchTerm.toLowerCase());
      final matchesCategory =
          _selectedCategory == "All" || product.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }
}
