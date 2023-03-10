import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/widgets/product_item.dart';
import 'package:shopapp/providers/products.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFav;
  ProductsGrid(this.showOnlyFav);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    List<Product> products;
    if (showOnlyFav)
      products = productsData.favItems;
    else
      products = productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: products[i],
            child: ProductItem(
                //  products[i].id, products[i].title, products[i].imageUrl),
                )));
  }
}
