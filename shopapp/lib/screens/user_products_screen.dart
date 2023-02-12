import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/edit_product.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/user_product_item.dart';

import '../providers/products.dart';

class UserProductScreen extends StatelessWidget {
  static final routeName = '/user-product';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    print('rebuilding...');
    return FutureBuilder(
      future: _refreshProducts(context),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  appBar: AppBar(title: const Text('Your Products'), actions: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(editProductScreen.routeName);
                      },
                    ),
                  ]),
                  drawer: AppDrawer(),
                  body: RefreshIndicator(
                    onRefresh: (() => _refreshProducts(context)),
                    child: Consumer<Products>(
                      builder: ((ctx, productsData, child) => Padding(
                            padding: const EdgeInsets.all(8),
                            child: ListView.builder(
                                itemCount: productsData.items.length,
                                itemBuilder: (_, i) {
                                  return UserProdItem(
                                      productsData.items[i].id,
                                      productsData.items[i].title,
                                      productsData.items[i].imageUrl);
                                }),
                          )),
                    ),
                  )),
    );
  }
}
