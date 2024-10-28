import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app_flutter/models/product_model.dart';
import 'package:shopping_app_flutter/screens/product_details_screen.dart';

class HomeScreenCmp extends StatefulWidget {
  const HomeScreenCmp({super.key});

  @override
  State<HomeScreenCmp> createState() => _HomeScreenCmpState();
}

class _HomeScreenCmpState extends State<HomeScreenCmp> {

  late Future<List<Product>> listOfProducts;
  List<Product> filteredProducts = [];
  String selectedCategory = "All";
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    listOfProducts = getProductsData();

    // Listen for changes in the search field
    searchController.addListener(() {
      setState(() {
        _filterProducts();
      });
    });
  }

  Future<List<Product>> getProductsData() async {
    try {
      var result =
      await http.get(Uri.parse("https://fakestoreapi.com/products"));
      var productListData = jsonDecode(result.body) as List;

      final products = productListData
          .map((product) => Product.fromJson(product))
          .toList();

      setState(() {
        filteredProducts = products;
      });

      return products;
    } catch (e) {
      throw e.toString();
    }
  }

  // Filter products based on search term and selected category
  void _filterProducts() {
    final searchTerm = searchController.text.toLowerCase();

    setState(() {
      listOfProducts.then((products) {
        filteredProducts = products.where((product) {
          final matchesSearch = searchTerm.isEmpty ||
              product.title.toLowerCase().contains(searchTerm) ||
              product.description.toLowerCase().contains(searchTerm);

          final matchesCategory = selectedCategory == "All" ||
              product.category == selectedCategory;

          return matchesSearch && matchesCategory;
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var border = const OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(50)));

    return Scaffold(
      body: FutureBuilder(
          future: listOfProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No Products Found"));
            }

            final products = snapshot.data!;

            final categories = [
              "All",
              ...products.map((product) => product.category).toSet()
            ];

            return SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Shoe\nCollection",
                          style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'suse',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: const Icon(Icons.search),
                            border: border,
                            enabledBorder: border,
                            focusedBorder: border,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: selectedCategory == category,
                            onSelected: (isSelected) {
                              setState(() {
                                selectedCategory = category;
                                searchController.text = ''; // Clear the search text
                                _filterProducts(); // Refresh the product list
                              });
                            },
                            selectedColor: Colors.yellow,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return ProductDetailsScreen(product: product);
                              }));
                            },
                            leading: Image.network(product.image,
                                width: 50, height: 50),
                            title: Text(product.title),
                            subtitle: Text("\$${product.price}"),
                            trailing: Text("${product.rating.rate} ★"),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
