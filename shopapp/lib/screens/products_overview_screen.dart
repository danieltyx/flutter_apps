import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/product_item.dart';

import '../product_grid.dart';

class productsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyShop'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (value) => print(value),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('!4!3!2!1'),
                  value: 0,
                ),
                PopupMenuItem(
                  child: Text('!!!!2'),
                  value: 1,
                ),
              ],
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
        body: ProductsGrid());
  }
}
