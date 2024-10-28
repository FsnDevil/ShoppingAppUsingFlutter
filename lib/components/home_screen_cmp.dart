import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/provider/product_provider.dart';
import 'package:shopping_app_flutter/screens/product_details_screen.dart';

class HomeScreenCmp extends StatelessWidget {
  const HomeScreenCmp({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    var border = const OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    );

    if(productProvider.isLoading){
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    return Scaffold(
      body: SafeArea(
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
                    onChanged: (value) => productProvider.setSearchTerm(value),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productProvider.categories.length,
                itemBuilder: (context, index) {
                  final category = productProvider.categories[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: productProvider.selectedCategory == category,
                      onSelected: (_) {
                        productProvider.setCategory(category);
                        productProvider.setSearchTerm('');
                      },
                      selectedColor: Colors.yellow,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: productProvider.filteredProducts.isEmpty
                  ? const Center(child: Text("No Products Found"))
                  : ListView.builder(
                itemCount: productProvider.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = productProvider.filteredProducts[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      onTap: () {
                        productProvider.passProductToProductDetailsScreen(product);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const ProductDetailsScreen(),
                          ),
                        );
                      },
                      leading: Image.network(product.image, width: 50, height: 50),
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
      ),
    );
  }
}
