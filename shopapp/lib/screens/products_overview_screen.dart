import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/badge.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/widgets/product_item.dart';
import 'package:shopapp/screens/cart_screen.dart';

import '../widgets/product_grid.dart';
import '../providers/products.dart';

enum FilterOptions { Favorites, all }

class productsOverviewScreen extends StatefulWidget {
  @override
  State<productsOverviewScreen> createState() => _productsOverviewScreenState();
}

class _productsOverviewScreenState extends State<productsOverviewScreen> {
  var _showOnlyFav = false;
  var _init = true;
  var _isLoading = false;

  // @override
  // void initState() {
  //   var _isLoading = true;
  //   print("INITSTATE OVERVIEW");
  //   Future.delayed(Duration.zero).then((value) {
  //     Provider.of<Products>(context)
  //         .fetchAndSetProducts()
  //         .then((value) => _isLoading = false);
  //   });
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    var _isLoading = true;
    if (_init) {
      Provider.of<Products>(context)
          .fetchAndSetProducts()
          .then((value) => _isLoading = false);
    }
    _init = false;
    super.didChangeDependencies();
    // Perform setup or resource allocation that depends on the dependencies of the widget
  }

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
                  icon: const Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(cartScreen.routeName);
                  }),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(_showOnlyFav));
  }
}
