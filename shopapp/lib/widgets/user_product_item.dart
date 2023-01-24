import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/edit_product.dart';
import 'package:shopapp/screens/user_products_screen.dart';

import '../providers/products.dart';

class UserProdItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProdItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(editProductScreen.routeName, arguments: id);
            },
            icon: const Icon(Icons.edit),
            color: Theme.of(context).colorScheme.secondary,
          ),
          IconButton(
            onPressed: () {
              Provider.of<Products>(context, listen: false).deleteProduct(id);
            },
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          ),
        ]),
      ),
    );
  }
}
