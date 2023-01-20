import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/badge.dart';
import 'package:shopapp/cart.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/product_item.dart';
import 'package:shopapp/screens/cart_screen.dart';

import '../product_grid.dart';
import '../providers/products.dart';

enum FilterOptions { Favorites, all }

class productsOverviewScreen extends StatefulWidget {
  @override
  State<productsOverviewScreen> createState() => _productsOverviewScreenState();
}

class _productsOverviewScreenState extends State<productsOverviewScreen> {
  var _showOnlyFav = false;
  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  if (value == FilterOptions.Favorites) {
                    _showOnlyFav = true;
                  } else {
                    _showOnlyFav = false;
                  }
                });
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: FilterOptions.Favorites,
                  child: Text('Only Favorites'),
                ),
                const PopupMenuItem(
                  value: FilterOptions.all,
                  child: Text('All'),
                ),
              ],
              icon: Icon(Icons.more_vert),
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) =>
                  Badge(value: cart.itemCount.toString(), child: ch!),
              child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(cartScreen.routeName);
                  }),
            )
          ],
        ),
        body: ProductsGrid(_showOnlyFav));
  }
}
