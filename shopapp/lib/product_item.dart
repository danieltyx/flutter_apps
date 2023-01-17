import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: Image.network(imageUrl, fit: BoxFit.cover),
        footer: GridTileBar(
          backgroundColor: Colors.black38,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            onPressed: null,
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_bag),
            onPressed: null,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
