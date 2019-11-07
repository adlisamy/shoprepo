import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final listOfProducts = Provider.of<Products>(context);
    final products =
        showFavs ? listOfProducts.favorietItems : listOfProducts.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(
          id: products[index].id,
          imageUrl: products[index].imageUrl,
          title: products[index].title,
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
    );
  }
}
