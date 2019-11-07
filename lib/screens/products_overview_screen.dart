import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../widgets/products_grid.dart';
import '../screens/cart_screen.dart';
import '../widgets/main_drawer.dart';

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    //...
                    // productsContainer.showFavoritesOnly();
                    _showFavoritesOnly = true;
                  } else {
                    //productsContainer.showAll();
                    _showFavoritesOnly = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                        child: Text('Only favorites'),
                        value: FilterOptions.Favorites),
                    PopupMenuItem(
                        child: Text('Show all'), value: FilterOptions.All),
                  ]),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              child: child,
              value: cart.countItems.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: ProductsGrid(_showFavoritesOnly),
    );
  }
}
